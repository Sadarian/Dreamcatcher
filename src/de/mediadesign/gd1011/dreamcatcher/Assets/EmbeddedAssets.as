package de.mediadesign.gd1011.dreamcatcher.Assets
{
    public class EmbeddedAssets
    {
        //BackgroundAtlas-->
        [Embed(source="/../assets/textures/1x/atlases/atlasOne.xml", mimeType="application/octet-stream")]
        public static const atlasOne:Class;

        [Embed(source="/../assets/textures/1x/atlases/atlasOneTexture.png")]
        public static const atlasOneTexture:Class;
        //<--BackgroundAtlas


        //All the following Embeddings will be transformed into Atlases after rework by the artists:
        [Embed(source="/../assets/textures/1x/Background.png")]
        public static const Background:Class;

        [Embed(source="/../assets/textures/1x/Dummy_Life_Bar.png")]
        public static const LifeBar:Class;

        [Embed(source="/../assets/textures/1x/DC_spriteSheetCharacterSmaller.png")]
        public static const PlayerOnly:Class;

        [Embed(source="/../assets/textures/1x/DC_spriteSheetGunArmSmaller.png")]
        public static const PlayerArm:Class;

        [Embed(source="/../assets/textures/1x/DC_sprite_Sheet_Boss_attack_distant_small.png")]
        public static const BossShooting:Class;

        [Embed(source="/../assets/textures/1x/DC_sprite_Sheet_Boss_walk_small.png")]
        public static const BossWalk:Class;

        [Embed(source="/../assets/textures/1x/DC_dummySpriteSheeWalkcycleEnemysmaller.png")]
        public static const EnemyWalk:Class;

        [Embed(source="/../assets/textures/1x/DC_spriteSheetVictimRunSmall.png")]
        public static const VictimWalk:Class;

        [Embed(source="/../assets/textures/1x/DummyBullet.png")]
        public static const PlayerBullet:Class;

        [Embed(source="/../assets/textures/1x/DC_sprite_Sheet_Enemy_Bullet.png")]
        public static const EnemyBullet:Class;

        [Embed(source="/../assets/textures/1x/GameStageBoss.png")]
        public static const GameStageBoss:Class;

        [Embed(source="/../assets/textures/1x/StageBushFrontBoss.png")]
        public static const GameStageFrontBoss:Class;

        [Embed(source="/../assets/textures/1x/AnimLayeBossr.png")]
        public static const GameStageAnimLayerBoss:Class;

        [Embed(source="/../assets/textures/1x/AnimLayerBackgroundBoss.png")]
        public static const ScrollingBackgroundBoss:Class;

        [Embed(source="/../assets/textures/1x/GameStageStagForegroundBoss.png")]
        public static const ScrollingForegroundBoss:Class;

        [Embed(source="/../assets/textures/1x/Button.png")]
        public static const Button:Class;

        //BitmapFonts
        [Embed(source="/../assets/fonts/testBitFont.fnt", mimeType="application/octet-stream")]
        public static const testBitmapFontXml:Class;

        [Embed(source="/../assets/fonts/testBitFont.png")]
        public static const testBitmapFont:Class;

        [Embed(source="/../assets/textures/1x/Circle.png")]
        public static const Circle:Class;

        [Embed(source="/../assets/textures/1x/Quad.png")]
        public static const Quad:Class;

		//TT-Fonts
		[Embed(source="/../assets/fonts/defused.ttf", embedAsCFF="false", fontFamily="TestFont")]
		private static const TestFont:Class;
		//Sounds
		[Embed(source="/../assets/audio/testSound.mp3")]
		private static const TestSound:Class;
	}
}
