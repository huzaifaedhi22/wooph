import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app/data/repository/auth_repo.dart';
import 'package:social_media_app/data/repository/db_queries.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final sl = GetIt.instance;

HttpLink httpLink = HttpLink(dotenv.env['graphQlUrl'] ?? '', defaultHeaders: {'apikey': dotenv.env['anonkey'] ?? '', 'content-type': 'application/json'});

final GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());

Future<void> init() async {
  final supabase = Supabase.instance.client;

  // registering singletons so they are created only once and available everywhere in the app.
  sl.registerLazySingleton<AuthServiceImpl>(() => AuthServiceImpl(client: supabase));
  sl.registerLazySingleton<dbQueryImpl>(() => dbQueryImpl(client: client, auth: supabase));
}
