package armory.logicnode;

import iron.math.Vec4;

class LerpFloatNode extends LogicNode {

	var v:Float = 0.0;
	var v1:Float;
	var v2:Float;
	var t=0.0;
	var c:Float;
	var f=0.0;
	var abo:Bool;

	public function new(tree:LogicTree) {
		super(tree);
	}

	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}

	override function run(from:Int) {
		v1 = inputs[1].get(); //Start Float
		v2 = inputs[2].get(); //End Float
		t = inputs[3].get(); //Duration

		f = 0.0;
		c = 1.0;
		
		f = (t / iron.system.Time.delta); //?
	}

	override function get(from:Int):Dynamic {
		abo = inputs[4].get();

		if (abo) {
			t = 0;
		}

		if (v1==null) {
			return v;
			c=1;
		}

		if (t > 0) {
			v = v1 + ((v2 - v1)/f) * c;
			t -= iron.system.Time.delta;
			c++;
			if(v > v2){
				return v2;
			} else {
				return fixedFloat(v);
			}
		} else {
			c = 1;
			return fixedFloat(v);
		}


	}
}
