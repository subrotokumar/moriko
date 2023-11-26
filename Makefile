watch:
	dart run build_runner clean
	dart run build_runner watch -d
gen:
	dart run build_runner clean
	dart run build_runner build -d

asset:
	fluttergen.bat -c ./pubspec.yaml
	mv lib\core\constants\assets.gen.dart lib\core\constants\assets.dart