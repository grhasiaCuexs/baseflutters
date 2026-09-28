import 'package:dio/dio.dart';
import 'package:myeshop/coreapp/data/api/static_api.dart';
import 'package:myeshop/modules/auth/main/data/models/params/signin_param.dart';
import 'package:myeshop/modules/auth/main/data/models/params/signup_param.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/root/data/model/base_response.dart';
import 'package:myeshop/modules/product/data/models/response/product_model.dart';
import 'package:myeshop/modules/product/data/models/response/product_paging_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ApiService;

  @POST(ApiStatic.login)
  Future<BaseResponse<SessionSignIn>> postSignIn(
    @Body() SignInParam param,
  );

  @POST(ApiStatic.signUp)
  Future<BaseResponse<SessionSignIn>> postSignUp(
    @Body() SignUpParam param,
  );

  @GET(ApiStatic.products)
  Future<ProductPagingResponse> getProducts(
    @Query("limit") int limit,
    @Query("skip") int skip,
  );

  @GET(ApiStatic.productDetail)
  Future<ProductModel> getProductDetail(
    @Path("id") int id,
  );
}
