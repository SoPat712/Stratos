import 'coord.dart';
import 'listpol.dart';

class Pollution {
	Coord? coord;
	List<Listpol>? listpol;

	Pollution({this.coord, this.listpol});

	factory Pollution.fromJson(Map<String, dynamic> json) => Pollution(
				coord: json['coord'] == null
						? null
						: Coord.fromJson(json['coord'] as Map<String, dynamic>),
				listpol: (json['list'] as List<dynamic>?)
						?.map((e) => Listpol.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'coord': coord?.toJson(),
				'listpol': listpol?.map((e) => e.toJson()).toList(),
			};
}
