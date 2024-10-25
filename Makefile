publish:
	fvm flutter pub publish

format:
	fvm flutter format lib test

generate_pigeons:
	fvm dart run pigeon --input pigeons/flutter_zebra_print.dart