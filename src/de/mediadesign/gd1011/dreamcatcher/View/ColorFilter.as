package de.mediadesign.gd1011.dreamcatcher.View
{
    import flash.display3D.Context3D;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Program3D;

    import starling.filters.FragmentFilter;
    import starling.textures.Texture;

    public class ColorFilter extends FragmentFilter
    {
        private var mQuantifiers:Vector.<Number>;
        private var mShaderProgram:Program3D;

        public function ColorFilter(red:Number=0.299, green:Number=0.587, blue:Number=0.114)
        {
            mQuantifiers = new <Number>[red, green, blue, 0];
        }

        public override function dispose():void
        {
            if (mShaderProgram) mShaderProgram.dispose();
            super.dispose();
        }

        protected override function createPrograms():void
        {
            var fragmentProgramCode:String =
                    "tex ft0, v0, fs0 <2d, clamp, linear, mipnone>  \n" + // read texture color
                            "mul ft0.xyz, ft0.xyz, fc0.xyz \n" +  // multiply color with quantifiers
                            "mov oc, ft0                   \n";   // output color

            mShaderProgram = assembleAgal(fragmentProgramCode);
        }

        protected override function activate(pass:int, context:Context3D, texture:Texture):void
        {
            context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, mQuantifiers, 1);
            context.setProgram(mShaderProgram);
        }
    }
}