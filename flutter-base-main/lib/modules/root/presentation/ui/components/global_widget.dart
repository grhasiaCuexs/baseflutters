import 'package:flutter/material.dart';
import 'package:myeshop/modules/root/presentation/ui/components/common_info_widget.dart';
import 'package:myeshop/style/custom_styles.dart';

class GlobalWidgets {
  static Widget tabTitleText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Color(0xFF878BAB), fontSize: 14),
    );
  }

  Widget isLoading() {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.blue,
      color: Colors.blueGrey[50],
      strokeWidth: 5,
    ));
  }
}

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    super.key,
    required this.title,
    required this.desc,
    this.onTapButton,
    this.buttonText = "Refresh",
    this.buttonIcon = const Icon(
      Icons.refresh,
      color: Colors.white,
    ),
    this.imgAsset
  });
  final String title;
  final String desc;
  final Function()? onTapButton;
  final String buttonText;
  final Widget buttonIcon;
  final String? imgAsset;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonInfoWidget(
          title: title,
          subTitle: desc,
          imgAsset: imgAsset ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        Visibility(visible: onTapButton != null, child: _btnRefresh(context, buttonText, buttonIcon))
      ],
    );
  }

  Widget _btnRefresh(BuildContext context, String buttonText, Widget buttonIcon,) {
    return InkWell(
        onTap: onTapButton,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: MyColors.medGreen,
            borderRadius: BorderRadius.circular(8),
            border: const Border(
              right: BorderSide(width: 1, color: MyColors.medGreen),
              bottom: BorderSide(width: 1, color: MyColors.medGreen),
            ),
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttonIcon,
                const SizedBox(width: 8),
                Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
        ));
  }
}

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
  });

  final Widget title;
  final Widget desc;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33B2B2B2),
            blurRadius: 10,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: title,
                )
              ]),
          const SizedBox(
            height: 10,
          ),
          desc
        ],
      ),
    );
  }
}

class TabItem {
  const TabItem(this.title, this.widgetBuilder);

  final Widget title;
  final WidgetBuilder widgetBuilder;
}

class CommonTabView extends StatefulWidget {
  const CommonTabView({
    super.key,
    required this.tabData,
    this.onModifyTitle,
    this.isScrollableTitleTab = true,
    this.tabAlignment = TabAlignment.start,
  });
  final List<TabItem> tabData;
  final Widget Function(Widget titleWidget)? onModifyTitle;
  final bool isScrollableTitleTab;
  final TabAlignment tabAlignment;

  @override
  State<CommonTabView> createState() => _CommonTabViewState();
}

class _CommonTabViewState extends State<CommonTabView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: widget.tabData.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTabBar(
          controller: tabController,
          tabAlignment: widget.tabAlignment,
          isScrollable: widget.isScrollableTitleTab,
          tabs: widget.tabData
              .map((tabItem) =>
                  widget.onModifyTitle?.call(tabItem.title) ??
                  Tab(
                    child: tabItem.title,
                  ))
              .toList(),
        ),
        Expanded(
          child: SizedBox(
            child: TabBarView(
                controller: tabController,
                children: widget.tabData
                    .map((tabItem) => tabItem.widgetBuilder.call(context))
                    .toList()),
          ),
        )
      ],
    );
  }
}

class CommonTabBar extends StatelessWidget {
  const CommonTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = true,
    this.tabAlignment = TabAlignment.start,
  });

  final TabController controller;
  final List<Widget> tabs;
  final bool isScrollable;
  final TabAlignment tabAlignment;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabAlignment: tabAlignment,
      isScrollable: isScrollable,
      unselectedLabelColor: const Color(0xFF878BAB),
      labelColor: const Color(0xFF080C2F),
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      labelStyle: const TextStyle(fontWeight: FontWeight.w700),
      indicator: const UnderlineTabIndicator(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Color(0xFF080C2F), width: 5.0)),
      tabs: tabs,
    );
  }
}
