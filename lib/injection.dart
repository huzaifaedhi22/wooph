import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app/data/repository/auth_repo.dart';
import 'package:social_media_app/data/repository/db_queries.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

HttpLink httpLink = HttpLink('https://qumuwpsrvxkplnxfptvc.supabase.co/graphql/v1', defaultHeaders: {'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF1bXV3cHNydnhrcGxueGZwdHZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDA1MjcsImV4cCI6MjAxMjE3NjUyN30.Pn6Gtxt3FAo4InycE7-UWdUbea4x6u9cuM1uslJr24Q', 'content-type': 'application/json'});

final GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());

Future<void> init() async {
  final supabase = Supabase.instance.client;

  // registering singletons so they are created only once and available everywhere in the app.
  sl.registerLazySingleton<AuthServiceImpl>(() => AuthServiceImpl(client: supabase));
  sl.registerLazySingleton<dbQueryImpl>(() => dbQueryImpl(client: client, auth: supabase));
}
