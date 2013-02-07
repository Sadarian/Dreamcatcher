/**
 * Created with IntelliJ IDEA.
 * User: hufuchsberger
 * Date: 05.02.13
 * Time: 11:01
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {
	public class AssetsTextureEmbeds_1x {

		//Bitmaps
		[Embed(source = "/../assets/textures/Background.png")]
		public static const Background:Class;

		[Embed(source = "/../assets/textures/DC_sprite_Sheet_Boss_attack_distant_small.png")]
		public static const testAnimation:Class;

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
