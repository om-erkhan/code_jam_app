import 'package:code_jam_app/resources/basic_exports.dart';
import 'package:code_jam_app/view_model/home_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  } on Exception catch (e) {
    runApp(CustomErrorWidget(errorMessage: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeViewModel())],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          title: "Foodies",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: const HomeView(),
        ),
      ),
    );
  }
}
