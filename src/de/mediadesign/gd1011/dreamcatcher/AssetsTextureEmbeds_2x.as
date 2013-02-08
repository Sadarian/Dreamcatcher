/**
 * Created with IntelliJ IDEA.
 * User: hufuchsberger
 * Date: 05.02.13
 * Time: 11:31
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {
	public class AssetsTextureEmbeds_2x {

		//Bitmaps
		[Embed(source = "/../assets/textures/2x/Background@2x.png")]
		public static const Background:Class;

		[Embed(source = "/../assets/textures/DC_dummyWalkcycleCharacter.png")]
		public static const testAnimation:Class;

		[Embed(source = "/../assets/textures/StageBushFront.png")]
		public static const StageFront:Class;

		[Embed(source = "/../assets/textures/Stage.png")]
		public static const Stage:Class;

		[Embed(source = "/../assets/textures/AnimLayer.png")]
		public static const AnimLayer:Class;

		// Particle Configurations
		[Embed(source="/../assets/particles/testParticle.pex", mimeType="application/octet-stream")]
		public static const testParticleConfig:Class;

		// Particle Texture
		[Embed(source="/../assets/particles/testParticleTexture.png")]
		public static const testParticleTexture:Class;

		//BitmapFonts
		[Embed(source="/../assets/fonts/testBitFont.fnt", mimeType="application/octet-stream")]
		public static const testBitmapFontXml:Class;

		[Embed(source = "/../assets/fonts/testBitFont.png")]
		public static const testBitmapFont:Class;


	}
}