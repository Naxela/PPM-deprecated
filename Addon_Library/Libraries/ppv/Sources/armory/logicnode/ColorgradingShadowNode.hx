package armory.logicnode;

class ColorgradingShadowNode extends LogicNode {

    public var property0:Dynamic;
    public var property1:Dynamic;
    public var property2:Dynamic;   
    public var property3:Dynamic;

    var value:Dynamic;
    var whitebalance:Dynamic;
    var tint:Dynamic;
    var saturation:Dynamic;
    var contrast:Dynamic;
    var gamma:Dynamic;
    var gain:Dynamic;
    var offset:Dynamic;

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function run(from:Int) {

        if(property0 == "Uniform"){

            arm.renderpath.PPV.colorgrading_global_uniforms[0][1] = inputs[1].get();

            for (i in 0...5){
                arm.renderpath.PPV.colorgrading_shadow_uniforms[i][0] = inputs[i+2].get();
                arm.renderpath.PPV.colorgrading_shadow_uniforms[i][1] = inputs[i+2].get();
                arm.renderpath.PPV.colorgrading_shadow_uniforms[i][2] = inputs[i+2].get();
            }

            //trace(inputs[6].get());

        } else if (property0 == "RGB") {

            arm.renderpath.PPV.colorgrading_global_uniforms[0][2] = inputs[1].get();

            for (i in 0...5){
                arm.renderpath.PPV.colorgrading_shadow_uniforms[i][0] = inputs[i+2].get().x;
                arm.renderpath.PPV.colorgrading_shadow_uniforms[i][1] = inputs[i+2].get().y;
                arm.renderpath.PPV.colorgrading_shadow_uniforms[i][2] = inputs[i+2].get().z;
            }

        } else if (property0 == "Preset File") {
            var value:Dynamic = inputs[0].get();
            var whitebalance:Float = inputs[1].get();
            var tint:iron.math.Vec4 = inputs[2].get();
            var saturation:Float = inputs[3].get();
            var contrast:Float = inputs[4].get();
            var gamma:Float = inputs[5].get();
            var gain:Float = inputs[6].get();
            var offset:Float = inputs[7].get();
        } else {
            var value:Dynamic = inputs[0].get();
            var whitebalance:Float = inputs[1].get();
            var tint:iron.math.Vec4 = inputs[2].get();
            var saturation:Float = inputs[3].get();
            var contrast:Float = inputs[4].get();
            var gamma:Float = inputs[5].get();
            var gain:Float = inputs[6].get();
            var offset:Float = inputs[7].get();
        }

        //trace(tint.x);

		runOutput(0);
	}
}
