import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class dbQuery {
  Future<List<Map<String, dynamic>>> fetchPosts();
  Future<void> createPost(String userid, String text, String imageUrl);
  Future<List<Map<String, dynamic>>> fetchUsers();
}

class dbQueryImpl extends dbQuery {
  GraphQLClient client;
  SupabaseClient auth;

  dbQueryImpl({required this.client, required this.auth});

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    String id = auth.auth.currentUser!.id.toString();
    final query = gql(r'''
 {
  postsCollection(first:20){
    edges{
      node{
        id,
        image_url,
        text,
        userid
      }
    }
  }
}
  ''');
    print(query);

    final QueryOptions options = QueryOptions(
      document: query,
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['postsCollection']['edges'] as List<dynamic>;

    // Convert the GraphQL response data to a list
    List<Map<String, dynamic>> posts = data.map((edge) {
      return {
        'id': edge['node']['id'],
        'text': edge['node']['text'],
        'image_url': edge['node']['image_url'],
        'userid': edge['node']['userid'],
      };
    }).toList();

    print(posts);

    return posts;
  }

  Future<void> createPost(String userid, String text, String imageUrl) async {
    String createPostMutation = '''
    mutation CreatePost(\$text: String!, \$imageUrl: String!, \$userid: String!) {
      insertIntopostsCollection(objects: [
        {
          text: \$text,
          image_url: \$imageUrl,
          userid: \$userid
        }
      ]) {
        affectedCount
        records {
          id
          text
          image_url
          userid
        }
      }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(createPostMutation),
      variables: {
        'text': text,
        'imageUrl': imageUrl,
        'userid': userid,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    } else {}
  }

  // fetch users

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final query = gql(r'''
   {
  profilesCollection(first:10
  ){
    edges{
      node{
        name,
        id,
      }
    }
  }
}
  ''');
    print(query);

    final QueryOptions options = QueryOptions(
      document: query,
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['profilesCollection']['edges'] as List<dynamic>;

    // Convert the GraphQL response data to a list
    List<Map<String, dynamic>> profiles = data.map((edge) {
      return {
        'id': edge['node']['id'],
        'name': edge['node']['name'],
      };
    }).toList();

    print(profiles);

    return profiles;
  }
}
