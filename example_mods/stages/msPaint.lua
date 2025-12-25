import flixel.math.FlxMath;
import openfl.text._internal.ShapeCache;
import deepend.game.OverclockBar;
import deepend.game.OverclockBarType;
import deepend.game.crud.CrudBg;
import flixel.group.FlxTypedSpriteGroup;
import deepend.game.DeependAnimate;
import deepend.system.utils.TweenUtil;
import deepend.DeependSprite;
import deepend.game.ColorSprite;
import flixel.math.FlxRect;
import deepend.game.HealthIcon;
import deepend.game.text.DeependText;
import flixel.util.FlxSpriteUtil;
import deepend.game.NoteSettings;

final ANGRY_NOTES_START = 219127;
final ANGRY_NOTES_END = 228666;

/**
 * 
 * @param {x:{speed:Float, min:Float, max:Float, dir:Bool}, y:that} 
 */
function scrollTick(params) {
	final dumb = [params.x, params.y];
	for (hi in dumb) {
		if (hi != null) {
			if (hi.dir == null)
				hi.dir = FlxG.random.bool(50);
		}
	}
	return (bg, _, __) -> {
		if (params.x != null)
			params.x.value ??= bg.x;
		if (params.y != null)
			params.y.value ??= bg.y;
		for (hi in dumb) {
			if (hi != null) {
				final dumb = hi.value;
				if (hi.dir)
					hi.value += hi.speed;
				else
					hi.value -= hi.speed;
				if (hi.dir && hi.value > hi.max || !hi.dir && hi.value < hi.min) {
					hi.value = dumb;
					hi.dir = !hi.dir;
				}
			}
		}
		if (params.x != null)
			bg.x = params.x.value;
		if (params.y != null)
			bg.y = params.y.value;
	}
}

final bgData = [
	{
		x: -250,
		y: -250,
		id: "crudwindows",
		anim: "crud_windows",
		scale: 3.5,
		beat: 32,
		onTick: scrollTick({x: {min: -249, max: -149, speed: 2}}),
	},
	{
		x: -175,
		y: -175,
		id: "museum",
		anim: "BG",
		scale: 3.5,
		beat: 96,
		onTick: scrollTick({y: {min: -365, max: -115, speed: 1}}),
	},
	{
		x: -250,
		y: -250,
		id: "crudspace",
		anim: "crud_space",
		scale: 3.5,
		beat: 160,
		onTick: (bg, _, t) -> {
			final t = t - .25;
			bg.x = FlxMath.lerp(-160, -240, (Math.cos(t * 4) + 1) * .5);
			bg.y = FlxMath.lerp(23, -440, (Math.sin(t) + 1) * .5);
		}
	},
	{
		x: -250,
		y: -250,
		id: "crudzoo",
		anim: "Gary_section_Zoo",
		scale: 3.5,
		beat: 224,
	},
	{
		x: -200,
		y: -200,
		id: "crudcharacters",
		anim: "characters",
		scale: 3.5,
		beat: 288,
		onTick: scrollTick({
			x: {min: -160, max: -250, speed: 6},
			y: {min: -445, max: -100, speed: 4}, // no fucking way
		}),
	},
	{
		x: -200,
		y: -200,
		id: "crudnado",
		anim: "cruddy-jeff-section",
		scale: 3.5,
		beat: 400,
		onTick: (bg, _, t) -> {
			bg.x = FlxMath.lerp(-149, -250, (Math.cos(t * 8) + 1) * .5);
			bg.y = FlxMath.lerp(-120, -440, (Math.sin(t * 2) + 1) * .5);
		}
	},
	{
		x: -200,
		y: -200,
		id: "crudmeteor",
		anim: "ezgif-3-5936cf33c7",
		scale: 2,
		beat: 464,
		onTick: {
			final params = {
				x: {min: -550, max: -150, speed: FlxG.random.float(25, 30)},
				y: {min: -597, max: -125, speed: FlxG.random.float(25, 30)},
			};
			final callback = scrollTick(params);
			(bg, _, __) -> {
				final lastDirX = params.x.dir;
				final lastDirY = params.y.dir;
				callback(bg, _, __);
				if (params.x.dir != lastDirX)
					params.x.speed = FlxG.random.float(25, 30);
				if (params.y.dir != lastDirY)
					params.y.speed = FlxG.random.float(25, 30);
			}
		}
	},
	{
		x: -200,
		y: -200,
		id: "burn",
		anim: "The Cruds",
		scale: 1.75,
		beat: 528,
		onTick: (bg, _, t) -> {
			bg.x = FlxMath.lerp(-149, -250, (Math.cos(t * 16) + 1) * .5);
			bg.y = FlxMath.lerp(-150, -250, (Math.sin(t * 2) + 1) * .5);
		}
	},
	{
		x: 200,
		y: 100,
		id: "cruddrinky",
		anim: "ezgif-6-28b0e65bc9",
		scale: 1.5,
		beat: 592,
	},
	{
		x: -200,
		y: -200,
		id: "crudbox",
		anim: "boxxer",
		scale: 3.5,
		beat: 656,
		onTick: scrollTick({y: {min: -440, max: -100, speed: 4}})
	},
	{
		x: -200,
		y: -200,
		id: "crudfalling",
		anim: "gary and bf fallying (2)",
		scale: 3.5,
		beat: 740,
	},
	{
		x: -200,
		y: -200,
		id: "crudcouch",
		anim: "couchsmaller",
		scale: 3,
		beat: 800,
		onTick: scrollTick({y: {min: -900, max: -100, speed: 4}})
	},
	{
		x: -150,
		y: -100,
		id: "thinking",
		anim: "The Cruds",
		scale: 6.7,
		beat: 864
	},
];

var jeffBar:OverclockBar;



final leftCurtain1 = -2500;
final leftCurtain2 = -200;

final rightCurtain1 = 2200;
final rightCurtain2 = 600;

final minX = 140;
final maxX = 1540;

final minY = 84;
final maxY = 884;

var starter = null;
var lol = null;

// all but overlay (contains gfGroup)
var bgGroup = new FlxTypedSpriteGroup();
// overlay
var hudGroup = new FlxTypedSpriteGroup();
// backgrounds
var crudBgGroup = new FlxTypedSpriteGroup();
// stage (contains dadGroup and boyfriendGroup)
var stageGroup = new FlxTypedSpriteGroup();

// overlay
var trails:DeependSprite;
var overlayBg:DeependSprite;
var barX:FlxSprite;
var barY:FlxSprite;
// text
var curTimeText:FlxText;
var curTimeTextBorder:FlxText;

// curtains
var leftCurtain:DeependSprite;
var rightCurtain:DeependSprite;

// actual bg
var ground:DeependSprite;
var side:DeependSprite;
var top:DeependSprite;

var canReadTime:Bool;
var secret:Bool;

final baseTextColor = 0xFFFFFF;
final borderTimeTextColor = 0xFFC3BFAF;

// characters
var jeff:Character;
var jeffGood:Character;
var crudDave:Character;
var crudDaveWhite:Character;
var gary:Character;
var crudBf:Character;

var jeffX:Float;
var jeffY:Float;
var garyX:Float;
var garyY:Float;
var daveX:Float;
var daveY:Float;

// song stuff
var bfFlung:DeependSprite;
var fuckYou:DeependAnimate;
var canCurtainsMove:Bool = true;

var p4Active:Bool = false;

var angryNotesHit:Float = .0;
var angryNotes:Int = 0;
var angryBump:FlxTween;

var altIconP1:HealthIcon;
var altLeft:FlxSprite;
var altIconP2:HealthIcon;
var altRight:FlxSprite; // uhhhhhhhhhhh
var altIconP2Offset = 0;
var doAltIconP2Bump = false;

var altIconP1Offset = 0;
var doAltIconP1Bump = false;

final iconDistance = 150 * .35;
final iconScale = .75;

var pathCanvas:FlxSprite;

// so its pixelated proopery?????
var copyAcc:DeependText;
var copyScore:DeependText;
var copyCounters = [];

var hasPartner = false;


function steppedEase(ease, steps) {
	final stepped = TweenUtil.stepped(steps);
	return t -> stepped(ease(t));
}

function loadCharacters() {
	return [
		{id: "jeff-good", type: DAD},
		// no dave or normal jeff cause its loaded by change character
	];
}

function loadingPost() {
	makeLagNoobs();
}

var madeLagNoobs = false;
function makeLagNoobs() {
	if (madeLagNoobs)
		return;
	madeLagNoobs = true;
	for (data in bgData) {
		final spr = new CrudBg(data);
		spr.visible = false;
		spr.active = false;
		spr.onTick = data.onTick;
		crudBgGroup.add(spr);
	}
	
	fuckYou = new DeependAnimate(760, 75, Paths.atlas("stages/msPaint/fuck you"));
	fuckYou.addSymbolForce("idle", "FUCK YOU!", 24, false);
	fuckYou.anim.play("idle");
	fuckYou.antialiasing = false;
	fuckYou.scale.set(1.5, 1.5);
	fuckYou.anim.onComplete.addOnce(() -> fuckYou.visible = false);
}

function onDestroy() {
	if (fuckYou.exists)
		fuckYou.destroy();
}

function onNoteStyleChange() {
	// i was gonna put the original crud noteskin in but im #lazy
	switch NoteSettings.instance.id {
		case 'classic':
			NoteSettings.setStyle("m1les-crud");
		default:
			NoteSettings.setStyle(NoteSettings.instance.id + "-crud");
	}
}

function onCreate() {
	onNoteStyleChange();
	game.leftCounterX = 215;
	game.insert(game.members.indexOf(game.partnerGroup), bgGroup);
	
	bgGroup.add(crudBgGroup);

	makeLagNoobs();
	crudBgGroup.members[0].visible = crudBgGroup.members[0].active = true;
	Console.registerObject("fun", crudBgGroup.members[0]);

	game.remove(game.gfGroup, true);
	bgGroup.add(game.gfGroup);

	leftCurtain = new DeependSprite(leftCurtain2, -300);
	leftCurtain.frames = Paths.getFrames('stages/msPaint/mainStage/curtains_left');
	leftCurtain.animation.addByPrefix('idle', 'show', 24);
	leftCurtain.animation.play('idle');
	leftCurtain.antialiasing = false;
	leftCurtain.scale.set(6, 6);
	leftCurtain.updateHitbox();
	bgGroup.add(leftCurtain);

	rightCurtain = new DeependSprite(rightCurtain2, -300);
	rightCurtain.frames = Paths.getFrames('stages/msPaint/mainStage/curtains_right');
	rightCurtain.animation.addByPrefix('idle', 'show right', 24);
	rightCurtain.animation.play('idle');
	rightCurtain.antialiasing = false;
	rightCurtain.scale.set(6, 6);
	rightCurtain.updateHitbox();
	bgGroup.add(rightCurtain);

	ground = new DeependSprite(-400, 600, Paths.image('stages/msPaint/mainStage/ground'));
	stageGroup.add(ground);

	// they are the exception
	if (PlayState.partnerSelect == "shades")
	{
		game.customPartner = false;
		game.remove(game.partnerGroup, true);
		stageGroup.add(game.partnerGroup);
		hasPartner = true;
	}

	trace('im crud');
	var crudPartner = null;
	if (PlayState.partnerSelect != "none" && PlayState.partnerSelect != "default" && PlayState.partnerSelect != "shades")
	{
		final partnerPath = Paths.image('stages/msPaint/partners/${PlayState.partnerSelect}');
		if (FlxG.assets.exists(partnerPath))
		{
			crudPartner = new DeependSprite(0, 0, partnerPath);
			crudPartner.scale.set(4, 4);
			crudPartner.updateHitbox();
			crudPartner.x = ground.x + (((ground.width * 2.5) - crudPartner.width) * .5);
			crudPartner.y = ground.y - crudPartner.height + (120);
			stageGroup.add(crudPartner);
			hasPartner = true;
		}
		else
		{
			trace('no aprtner', partnerPath);
		}
	}

	side = new DeependSprite(-400, -200, Paths.image('stages/msPaint/mainStage/bgSide'));
	stageGroup.add(side);
	top = new DeependSprite(-400, -200, Paths.image('stages/msPaint/mainStage/bgTop'));
	stageGroup.add(top);

	bgGroup.add(stageGroup);

	for (ok in stageGroup.members) {
		ok.antialiasing = false;
		if (ok.scale.x == 1 && ok.scale.y == 1) {
			ok.scale.set(2.5, 2.5);
			ok.updateHitbox();
		}
	}

	game.remove(game.dadGroup);
	game.remove(game.boyfriendGroup);
	final pos = hasPartner ? 2 : 1;
	stageGroup.insert(pos, game.dadGroup);
	stageGroup.insert(pos, game.boyfriendGroup);

	hudGroup.cameras = [game.camOther];

	trails = new DeependSprite(0, 0, Paths.image('stages/msPaint/mainStage/trails'));
	hudGroup.add(trails);
	overlayBg = new DeependSprite(0, 0, Paths.image('stages/msPaint/overlay/initial'));
	overlayBg.screenCenter();
	hudGroup.add(overlayBg);
	barX = new DeependSprite(256, overlayBg.y + 600, Paths.image('stages/msPaint/overlay/horizontal'));
	hudGroup.add(barX);
	barY = new DeependSprite(1163, 147, Paths.image('stages/msPaint/overlay/vertical'));
	hudGroup.add(barY);

	bfFlung = new FlxSprite(0, 0, Paths.image('stages/msPaint/WEEE'));
	bfFlung.screenCenter();
	bfFlung.cameras = [game.camOther];
	bfFlung.visible = false;
	hudGroup.insert(0, bfFlung);

	game.add(hudGroup);

	//testBounds = new ColorSprite(0, 0, 100, 100);
	//Console.registerObject('testBounds', testBounds);
	//game.add(testBounds);


	for (spr in hudGroup.members)
		spr.antialiasing = false;

	Console.registerObject("fuckYou", fuckYou);
}

function loadImages() {
	final images = [];
	for (i in ['fuck you', 'WEEE'])
		images.push('stages/msPaint/$i');
	for (i in ['trails', 'ground', 'bgSide', 'bgTop', 'curtains_left', 'curtains_right'])
		images.push('stages/msPaint/mainStage/$i');
	for (i in ['intial', 'horizontal', 'vertical'])
		images.push('stages/msPaint/overlay/$i');
	for (data in bgData)
		images.push('stages/msPaint/bgs/${data.id}');
	return images;
}

function runCurtainCam(startDelay) {
	if (starter != null)
		starter.cancel();
	starter = game.timer(startDelay, _ -> {
		if (lol != null)
			lol.cancel();
		game.camLock = true;
		final prevZoom = game.defaultCamZoom;
		game.defaultCamZoom = .566;
		game.camGame.camFollow.setPosition(812, 317);
		lol = game.timer(1, _ -> {
			game.camLock = false;
			if (game.defaultCamZoom == .566)
				game.defaultCamZoom = prevZoom;
		});
	});	
}

function onSongStart() {
	timeLoadingTimer.cancel();
	canReadTime = true;
}

var dots = 1;
function loadingTimerCallback(t) {
	dots++;
	dots %= 4;
	var txt = 'Loading';
	for (i in 0...dots)
		txt += '.';
	curTimeText.text = curTimeTextBorder.text = txt;
}

function crudify(txt) {
	txt.fieldWidth = 0;
	txt.borderColor = 0x00;
	txt.size = 20;
	txt.font = 'arial/arial.ttf';
	txt.textField.antiAliasType = 0;
	txt.textField.sharpness = 400;
	txt.antialiasing = false;
	txt.cameras = [game.camOther];
}

function getCopy() {
	final txt = new DeependText();
	txt.color = FlxColor.BLACK;
	txt.font = 'arial/arial.ttf';
	txt.size = 20;
	txt.textField.antiAliasType = 0;
	txt.textField.sharpness = 400;
	txt.antialiasing = false;
	game.healthBarGroup.add(txt);
	return txt;
}

function onCreatePost() {
	trace('hi im stagey');
	curTimeText = new FlxText(256 + 5, 12, 0, '', 25);
	curTimeText.color = baseTextColor;
	curTimeTextBorder = new FlxText(257 + 5, 13, 0, '', 25);
	curTimeTextBorder.color = borderTimeTextColor;
	curTimeText.font = curTimeTextBorder.font = Paths.font('arial/arial.ttf');
	hudGroup.add(curTimeTextBorder);
	hudGroup.add(curTimeText);

	timeLoadingTimer = game.timer(.3, loadingTimerCallback, 0);

	for (text in [curTimeText, curTimeTextBorder]) {
		text.antialiasing = false;
		text.textField.antiAliasType = 0;
		text.textField.sharpness = 400;
		text.text = 'Loading.';
		text.alignment = 'left';
	}

	for (i => v in game.counterGroup.members) 
	{
		copyCounters[i] = [getCopy(), getCopy()];
		v.members[1].x += 30;
		for (o => txt in v.members)
		{
			txt.y = 25 + 550 + (22.5 * (i - 1));
			crudify(txt);
		}
	}

	crudify(game.accuracyTxt);
	game.accuracyTxt.setPosition(1089, 665);
	crudify(game.scoreTxt);
	game.scoreTxt.setPosition(1089, 665 + 20);
	game.rightCountersOffset = 75;
	copyAcc = getCopy();
	copyScore = getCopy();
	game.alignRightCounters();

	game.healthBar.y += 20;
	game.iconP1.y = game.iconP2.y = game.healthBar.y - 75;
	//game.accuracyTxt.size = 50;
	//game.timer(.25, _ -> {
	//	game.accuracyTxt.size = 25;
	//	game.accuracyTxt.text = "ok cool";
	//	game.timer(.25, _ -> {
	//		game.accuracyTxt.size = 25;
	//		game.accuracyTxt.text = "10 0%";
	//		game.timer(.25, _ -> {
	//			game.accuracyTxt.text = "fuck you";
	//		});
	//	});
	//});

	for (i in game.strumLineNotes.members) {
		//i.pixelPerfectPosition = i.pixelPerfectRender = true;
		//i.pixelPerfectScale = 4;
	}


	game.camGame.scrollOffset.y = 50;
	game.camGame.followType = 'linear';
	game.cameraSpeed = 25;
	game.camZoomingMult = 0;
	game.camStrums.zoom = game.camStrums.defaultZoom = .8;
	game.camStrums.x = 50;
	if (ClientPrefs.downscroll) {
		game.camStrums.y = -30;
		game.judgementCounter.y -= 75;
	} else {
		game.camStrums.y += 10;
	}
	game.camGame.snapToTarget();

	for (camera in FlxG.cameras.list)
	{
		if (camera != game.camStrums)
			camera.pixelPerfectRender = true;
	}

	game.timeBarGroup.visible = false;
	game.healthBarGroup.cameras = [game.camOther];

	jeffBar = new OverclockBar(-90, 100, FlxColor.RED, OverclockBarType.JEFF, .75);
	jeffBar.cameras = [game.camOther];
	jeffBar.value = 1;
	game.add(jeffBar);

	// character horrible stuff

	if (game.partner != null)
	{
		game.partner.scale.set(1, 1);
		game.partner.x -= 250;
		game.partner.y += 200;
	}

	jeff = game.dadMap.get("jeff");
	jeff.y += 50;
	jeffX = jeff.x;
	jeffY = jeff.y;
	jeff.setPosition(540, 210);
	jeff.playAnim("blast", true, false, 84);
	jeff.swfSprite.playing = false;

	game.addCharacterToList("jeff-good", DAD);
	jeffGood = game.dadMap.get("jeff-good");
	jeffGood.y += 50;
	game.dadGroup.remove(jeffGood);
	final pos = hasPartner ? 4 : 3;
	stageGroup.insert(pos, jeffGood);

	crudDave = game.boyfriendMap.get("dave-crud");
	game.boyfriendGroup.remove(crudDave);
	game.boyfriendGroup.insert(0, crudDave);
	crudDaveWhite = game.boyfriendMap.get("dave-crud-white");
	crudDaveWhite.x += 50;
	daveX = crudDaveWhite.x;
	daveY = crudDaveWhite.y;
	crudDaveWhite.setPosition(830, -5);
	
	// use group to retain positions
	game.boyfriendGroup.group.remove(crudDaveWhite);
	game.dadGroup.group.remove(jeff, true);

	game.gfGroup.group.add(crudDaveWhite);
	game.gfGroup.group.add(jeff);

	gary = game.dad;
	garyX = game.garyX;
	garyY = game.garyY;

	crudBf = game.boyfriend;

	game.dadGroup.remove(gary);
	game.dadGroup.add(gary);

	game.boyfriendGroup.remove(game.boyfriend);
	game.boyfriendGroup.add(game.boyfriend);

	Console.registerObject("jeffBar", jeffBar);

	// count jeff bar notes
	for (note in game.noteDataArray) {
		if (note.time > ANGRY_NOTES_END)
			break;
		if (note.time > ANGRY_NOTES_START && !note.gottaHit)
			angryNotes++;
	}
	trace('angrynotes', angryNotes);

	// icon stuff
	altIconP1 = new HealthIcon(game.boyfriend.healthIcon, true);
	altIconP1.playAnim("lose");
	game.healthBarGroup.add(altIconP1);

	altIconP2 = new HealthIcon(jeff.healthIcon, false);
	altIconP2.playAnim("lose");
	game.healthBarGroup.add(altIconP2);

	altLeft = new FlxSprite(0, 0, Paths.image('healthBar_crud_half'));
	altLeft.offset.set(game.healthBar.left.offset.x, game.healthBar.left.offset.y);
	game.healthBar.add(altLeft);
	altLeft.setPosition(game.healthBar.left.x - 1, game.healthBar.left.y);
	
	altRight = new FlxSprite(0, 0, Paths.image('healthBar_crud_half'));
	altRight.offset.set(game.healthBar.right.offset.x, game.healthBar.right.offset.y);
	game.healthBar.add(altRight);
	altRight.setPosition(game.healthBar.right.x - 1, game.healthBar.right.y);

	altLeft.antialiasing = altRight.antialiasing = false;
	altRight.visible = altLeft.visible = false;

	altLeft.color = altLeftBarColor = gary.healthColor;
	altRight.color = altRightBarColor = crudDave.healthColor;
	
	altIconP1.visible = altIconP2.visible = false;
	game.leftCounterX = 185;
}

function onUpdatePost(e) {
	if (game.inGameOver)
		return;
	game.camGame.zoom = Math.floor(game.camGame.zoom / .025) * .025;
	final xx = game.camGame.scroll.x + (FlxG.width * .5);
	final yy = game.camGame.scroll.y + (FlxG.height * .5);

	final xPerc = (xx - minX) / (maxX - minX);
	final yPerc = (yy - minY) / (maxY - minY);

	barX.x = Math.floor(FlxMath.lerp(256, 721, xPerc));
	barY.y = Math.floor(FlxMath.lerp(147, 333, yPerc));
	//if (FlxG.keys.justPressed.A) {
	//	game.accuracyTxt.textField.__textEngine.__shapeCache.__shortWordMap.clear();
	//	game.accuracyTxt.textField.__textEngine.__shapeCache.__longWordMap.clear();
	//	game.accuracyTxt.textField.__dirty = true;
	//}
	//	game.accuracyTxt.size = 50;

	if (canReadTime) {
		final txt = game.timeTxt.text;
		if (curTimeText.text != txt) {
			curTimeText.text = curTimeTextBorder.text = txt;
			if (StringTools.startsWith(curTimeText, '4:45')) {
				if (!secret) {
					if (FlxG.random.int(0, 99) <= 45) {
						curTimeText.color = borderTimeTextColor;
						curTimeTextBorder.color = baseTextColor;
					}
					secret = true;
				}
			} else if (curTimeText.color == borderTimeTextColor) {
				curTimeText.color = baseTextColor;
				curTimeTextBorder.color = borderTimeTextColor;
			}
		}
	}

	if (crudDave != game.boyfriend)
		crudDave.checkDoneSinging();

	//if (FlxG.keys.justPressed.H)
	//	doFuckYou();

	if (doAltIconP2Bump) {
		game.iconP2.y = game.healthBar.y - 75 + (altIconP2Offset * 150 * .25);
		final dist = iconDistance * altIconP2Offset;
		final scale = FlxMath.lerp(1, iconScale, altIconP2Offset);
		altIconP2.setPosition(game.iconP2.x - (dist), game.iconP2.y - (dist * 1.25));
		altIconP2.playAnim(game.iconP2.animation.curAnim.name);
		altIconP2.multScale.set(scale, scale);
		game.iconP2.multScale.set(scale, scale);
	}

	if (doAltIconP1Bump) {
		game.iconP1.y = game.healthBar.y - 75 + (altIconP1Offset * 150 * .25);
		final dist = iconDistance * altIconP1Offset;
		final scale = FlxMath.lerp(1, iconScale, altIconP1Offset);
		altIconP1.setPosition(game.iconP1.x + (dist), game.iconP1.y - (dist * 1.25));
		altIconP1.playAnim(game.iconP1.animation.curAnim.name);
		altIconP1.multScale.set(scale, scale);
		game.iconP1.multScale.set(scale, scale);
	}

	copyClipRect(altLeft, game.healthBar.left);
	copyClipRect(altRight, game.healthBar.right);

	game.accuracyTxt.visible = false;
	game.scoreTxt.visible = false;
	copyAcc.text = game.accuracyTxt.text;
	copyScore.text = game.scoreTxt.text;
	copyAcc.setPosition(game.accuracyTxt.x, game.accuracyTxt.y);
	copyScore.setPosition(game.scoreTxt.x, game.scoreTxt.y);

	for (i => v in copyCounters) {
		for (o => txt in v) {
			final og = game.counterGroup.members[i].members[o];
			og.visible = false;
			txt.text = og.text;
			txt.setPosition(og.x, og.y);
		}
	}
}

function copyClipRect(a, b) {
	tryFunc(() -> {
		a.clipRect ??= FlxRect.get();
		final ca = a.clipRect;
		final cb = b.clipRect;
		ca.set(Math.floor(cb.x), Math.floor(cb.y), Math.floor(cb.width), Math.floor(cb.height));
		a.frame = a.frame;
	});
}

function getScriptOrder() {
	return 99;
}

function onNoteSpawn(d) {
	if (d.trail != null)
		d.trail.alpha = 1;
}

function init4Player() {
	final positionOffsetX = jeffGood.positionArray.x - game.dad.positionArray.x;
	final positionOffsetY = jeffGood.positionArray.y - game.dad.positionArray.y;

	jeffGood.x = game.dad.x + positionOffsetX;
	jeffGood.y = game.dad.y + positionOffsetY;
}

function multiPlayerMode() {
	jeffGood.playAnim("turninto");
	jeffGood.specialAnim = true;
	jeffGood.alpha = 1;

	crudDave.playAnim("transition");
	crudDave.specialAnim = true;
	crudDave.idleSuffix = "-alt";
	crudDave.alpha = 1;
	p4Active = true;
	trace('p4 active ok', p4Active);
}

function onBeatHit() {
	if (crudDave != game.boyfriend)
		crudDave.danceCheck(game.curBeat);
	if (gary != game.dad)
		gary.danceCheck();
	jeffGood.danceCheck(game.curBeat);

	if (doAltIconP2Bump)
		game.bumpIcon(altIconP2, BumpDirection.LEFT);
	if (doAltIconP1Bump)
		game.bumpIcon(altIconP1, BumpDirection.RIGHT);
}

var lastPlayer:Character;
function onSing(data, char) {
	final missPress = data.mustPress && data.ignoreNote && data.miss;
	if (p4Active && (missPress || data.note.gfNote)) {
		final char = data.note.mustPress ? crudDave : jeffGood;
		if (missPress && lastPlayer != char)
			return false;
		else
			lastPlayer = char;
		data.alt = true;
		data.altSuffix = char.idleSuffix;
		char.singFromData(data);
		return true;
	}
	return false;
}

// events
var bgIndex = 0;
final weirdos = [0, 5, 11];
function doBeat(beat) {
	final bg = crudBgGroup.members[bgIndex];
	if (bg != null) {
		final weirdo = weirdos.contains(bgIndex);
		if (beat == bg.params.beat && weirdo) {
			trace('ok moving out');
			bg.visible = false;
			switchBg(bgIndex);
			bgIndex++;
			trace('bg index from instant move', bgIndex);
			moveCurtainsOut(1.5, 0);
		} else if (beat == bg.params.beat - 4 && !weirdo) {
			moveCurtains();
			trace('bg index', bgIndex);
		}
	}
	switch beat {
		case 160:
			game.defaultCamZoom = .6;
		case 224:
			game.defaultCamZoom = .55;
		case 288:
			game.defaultCamZoom = .5;
		case 347:
			jeff.swfSprite.playing = true;
		case 350:
			game.boyfriend.skipDance = true;
			game.boyfriend.playAnim("huh");
			canCurtainsMove = false;
			moveCurtains();
			jeffIntro();
		case 352:
			// handled in onEvent
		case 384:
			game.gfSpeed = 0;
		case 397:
			canCurtainsMove = true;
			gary.skipDance = true;
			gary.playAnim("shutUp");
			doAltIconP2Bump = false;
			altIconP2Offset = 0;
			gary.animationFrameCallback = function(name:String, frameNumber:Int) {
				if (frameNumber >= 2)
					altIconP2.playAnim("lose");
				if (frameNumber >= 13) {
					game.tweenManager.color(altLeft, .5, altLeft.color, game.healthBar.left.color);
					game.tween(gary, {x: gary.x - 1000}, 0.5, {ease: TweenUtil.stepped(16)});
					game.tween(altIconP2, {x: altIconP2.x - 1000, angle: 360}, 0.5, {ease: TweenUtil.stepped(16)});
					game.tween(game.iconP2, {y: game.healthBar.y - 75}, .5);
					game.tween(game.iconP2.multScale, {x: 1, y: 1}, .5);
					gary.animationFrameCallback = null;
				}
			}
			game.tweenManager.num(.75, 1, beatTime(3) - .09, {ease: TweenUtil.stepped(18)}, t -> jeffBar.value = t);
		case 398:
			game.gfSpeed = 1;
		case 400:
			game.defaultCamZoom = .5;
		case 448:
			game.defaultCamZoom = .6;
		case 462:
			game.defaultCamZoom = game.camZoom = .8;
		case 464:
			game.defaultCamZoom = .5;
		case 528:
			game.defaultCamZoom = .6;
		case 652:
			game.defaultCamZoom = .5;
		case 654:
			doFuckYou();
		case 720:
			game.defaultCamZoom = .6;
			game.tween(jeffBar, {x: 90}, stepTime(4), {ease: steppedEase(FlxEase.cubeOut, 8)});
		case 728:
			game.defaultCamZoom = .8;
		case 732:
			game.defaultCamZoom = .9;
		case 736:
			game.defaultCamZoom = .7;
		case 752:
			game.tweenManager.num(.25, 0, beatTime(36) + (27/24), {ease: TweenUtil.stepped(36 * 4)}, t -> jeffBar.value = t);
		case 796:
			canCurtainsMove = true;
			game.tween(jeffBar, {x: -90}, stepTime(4), {ease: steppedEase(FlxEase.cubeOut, 8)});
		case 784:
			game.defaultCamZoom = .5;
			canCurtainsMove = false;
			moveCurtains();
			game.updateIcons = false;
			game.preventReloadHealthBarColors = true;
			altLeft.color = game.healthBar.left.color;
			altRight.color = game.healthBar.right.color;
			//game.tweenManager.num(0, 1, beatTime(2), null, o -> setHealthWhiteOffset(o));
		case 792:
			//game.tweenManager.num(1, 0, beatTime(2), null, o -> setHealthWhiteOffset(o));
	}
}

function onEvent(event, value1, value2) {
	switch event {
		case "Change Character":
			switch value2 {
				case "dave-crud-white" if (value1 == "0"):
					altLeft.visible = true;
					gary.idleSuffix = '-alt';
					gary.dance();
					game.tween(gary, {x: 40, y: 110}, .5, {ease: steppedEase(FlxEase.cubeOut, 5)});
					gary.alpha = 1;
			
					game.tween(crudDaveWhite, {x: daveX, y: daveY}, .5, {ease: TweenUtil.stepped(5)});
					jeff.y = jeffY;

					altIconP1.x = game.healthBar.x + (game.healthBar.width * .5);
					altIconP1.y = game.iconP1.y;
					altIconP1.visible = true;
					final ease = TweenUtil.stepped(16);
					game.tween(altIconP1, {y: altIconP1.y - 100}, .25, {ease: steppedEase(FlxEase.expoOut, 32), onComplete: _ -> {
						game.tween(altIconP1, {y: altIconP1.y + 400}, .25, {ease: steppedEase(FlxEase.expoIn, 32)});
					}});
					game.tween(altIconP1.scale, {x: 1.25, y: 1.25}, .5, {ease: ease});
					game.tweenManager.color(altIconP1, 1, FlxColor.WHITE, FlxColor.BLACK, {onComplete: _ -> altIconP1.color = FlxColor.WHITE});
				case "jeff":
					game.dad.x -= 100;
					game.dad.y += 25;
					game.tweenManager.cancelTweensOf(altIconP2);
					altIconP2.changeIcon(gary.healthIcon);
					altIconP2.flipX = false;
					game.healthBarGroup.group.remove(altIconP2);
					game.healthBarGroup.group.insert(1, altIconP2);
					doAltIconP2Bump = true;
					game.healthBar.lerpSpeed = 0;
					game.tweenManager.num(0, 1, .5, {ease: steppedEase(FlxEase.backOut, 16)}, n -> altIconP2Offset = n);
					leftBarColor = jeff.healthColor;
					rightBarColor = crudDave.healthColor;
					game.tweenManager.num(1, 0, .5, {ease: steppedEase(FlxEase.cubeOut, 16), onComplete: _ -> game.healthBar.lerpSpeed = .1}, n -> {
						game.health = 2 + FlxG.random.float(-n * .9, n * .9);
						setHealthWhiteOffset(n);
					});
				case "bf-crud" if (value1 == "BF"):
					game.boyfriend.visible = false;
					rightBarColor = crudBf.healthColor;
					setHealthWhiteOffset(1);
				case "gary" if (value1 == "Dad"):
					game.dad.visible = false;
					game.dad.setPosition(370, 135);
					gary.skipDance = false;
					gary.idleSuffix = '';
					game.typeCameraOverride.set(DAD, jeff);
					leftBarColor = jeff.healthColor;
					setHealthWhiteOffset(1);
			}
		case "Play Animation":
			if (value1 == "stage") {
				switch value2 {
					case "Dad":
						game.dad.visible = true;
						game.dad.x += 100;
						game.dad.y += 50;
						altIconP2.setPosition(game.iconP2.x, -300);
						altIconP2.alpha = 0;
						game.tween(altIconP2, {alpha: 1}, .2, {ease: FlxEase.expoIn, startDelay: .3});
						game.tweenManager.num(altIconP2.y, game.iconP2.y, .5, {ease: TweenUtil.stepped(32), onComplete: _ -> {
							doAltIconP2Bump = true;
							altIconP2.changeIcon(jeffGood.healthIcon);
							game.iconP2.changeIcon(gary.healthIcon);
							altLeft.visible = true;
							altLeft.color = game.healthBar.left.color;
							final ease = steppedEase(FlxEase.backOut, 32);
							game.tweenManager.color(game.healthBar.left, .5, game.healthBar.left.color, gary.healthColor, {ease: ease});
							game.tweenManager.num(0, 1, .5, {ease: ease}, n -> altIconP2Offset = n);
						}}, n -> {
							altIconP2.x = game.iconP2.x;
							altIconP2.y = n;
						});
						game.tweenManager.num(game.health, 2, .5, null, h -> game.health = h);
					case "BF":
						game.boyfriend.visible = true;
						game.boyfriend.skipDance = false;
						game.boyfriend.x += 100;
						game.boyfriend.y += 50;
						altIconP1.setPosition(game.iconP1.x, -300);
						altIconP1.scale.set(1, 1);
						game.healthBarGroup.group.remove(altIconP1);
						game.healthBarGroup.group.insert(1, altIconP1);
						altIconP1.angle = 360;
						altIconP1.alpha = 0;
						game.tween(altIconP1, {alpha: 1}, .2, {ease: FlxEase.expoIn, startDelay: .3});
						game.tweenManager.num(altIconP1.y, game.iconP1.y, .5, {ease: TweenUtil.stepped(32), onComplete: _ -> {
							doAltIconP1Bump = true;
							altIconP1.changeIcon(crudDaveWhite.healthIcon);
							game.iconP1.changeIcon(crudBf.healthIcon);
							altRight.visible = true;
							altRight.color = game.healthBar.right.color;
							final ease = steppedEase(FlxEase.backOut, 32);
							game.tweenManager.color(game.healthBar.right, .5, game.healthBar.right.color, crudBf.healthColor, {ease: ease});
							game.tweenManager.num(0, 1, .5, {ease: ease}, n -> altIconP1Offset = n);
						}}, n -> {
							altIconP1.x = game.iconP1.x;
							altIconP1.y = n;
						});
				}
			}
	}
}


var leftBarColor:FlxColor;
var rightBarColor:FlxColor;
var altLeftBarColor:FlxColor;
var altRightBarColor:FlxColor;
function setHealthWhiteOffset(o) {
	//game.healthBar.left.color = FlxColor.interpolate(leftBarColor, FlxColor.WHITE, o);
	//game.healthBar.right.color = FlxColor.interpolate(rightBarColor, FlxColor.WHITE, o);	
	//altLeft.color = FlxColor.interpolate(leftBarColor, FlxColor.WHITE, o);
	//altRight.color = FlxColor.interpolate(rightBarColor, FlxColor.WHITE, o);	
}

function doFuckYou() {
	fuckYou.setPosition(crudDaveWhite.x - 400, crudDaveWhite.y - 250);
	game.add(fuckYou);
}

function jeffIntro() {
	game.gfGroup.group.remove(jeff);
	game.dadGroup.group.insert(0, jeff);
	game.gfGroup.group.remove(crudDaveWhite);
	game.boyfriendGroup.group.insert(0, crudDaveWhite);
	game.tween(jeff, {x: jeff.x - 1000}, stepTime(6), {ease: steppedEase(FlxEase.quartIn, 32), onComplete: _ -> {
		game.dadGroup.group.remove(gary, true);
		game.dadGroup.group.insert(0, gary);
		jeff.x = 1852;
		jeff.y = jeffY;
		game.tween(jeff, {x: 852}, stepTime(2), {ease: TweenUtil.stepped(16), onComplete: _ -> {
			game.tween(jeff, {x: jeffX}, stepTime(4), {ease: steppedEase(FlxEase.sineOut, 16)});
			bfFlung.x += 100;
			bfFlung.visible = true;
			final ease = TweenUtil.stepped(16);
			game.tween(bfFlung, {x: bfFlung.x - 100, angle: (360 * 2) + 210}, .5, {ease: ease});
			game.tween(bfFlung.scale, {x: 2, y: 2}, .5, {onComplete: _ -> {
				game.camOther.shake(0.01, 0.1);
				game.timer(.25, _ -> {
					game.tween(bfFlung, {y: FlxG.height * 1.5, angle: bfFlung.angle + 15}, .75, {ease: steppedEase(FlxEase.cubeIn, 16)});
				});
			}, ease: ease});
		}});
		altIconP2.visible = true;
		altIconP2.x = FlxG.width;
		altIconP2.y = game.iconP2.y;
		altIconP2.flipX = true;
		game.tween(altIconP2, {x: game.iconP2.x}, stepTime(2), {ease: TweenUtil.stepped(16)});
	}});
}

final ease = steppedEase(FlxEase.expoOut, 32);
function switchBg(index) {
	final other = crudBgGroup.members[index - 1];
	if (other != null)
		other.visible = other.active = false;
	else
		trace('it was null');
	final ok = crudBgGroup.members[index];
	ok.visible = ok.active = true;
	Console.registerObject("curBg", ok);
}

var moveLeftCurtain = null;
var moveRightCurtain = null;
function moveCurtains() {
	if (moveLeftCurtain != null)
		moveLeftCurtain.cancel();
	if (moveRightCurtain != null)
		moveRightCurtain.cancel();

	moveLeftCurtain = game.tween(leftCurtain, {x: leftCurtain2}, stepTime(4 * 4), {ease: ease, onComplete: leftCurtainCallback});
	moveRightCurtain = game.tween(rightCurtain, {x: rightCurtain2}, 1, {ease: ease});
}

function leftCurtainCallback(_) {
	trace('ikm left curatin callback');
	if (crudBgGroup.members[bgIndex].params.id == 'crudcharacters') {
		jeff.alpha = 1;
		crudDaveWhite.alpha = 1;
		crudDaveWhite.offset.set(-40, -140); // dont know what caused this but ok
	}
	if (canCurtainsMove) {
		trace('curtains can move :)');
		switchBg(bgIndex);
		bgIndex++;
		moveCurtainsOut(1.5, 2);
	} else {
		trace('no curtain move :(');
	}
}

var moveLeftCurtainAway = null;
var moveRightCurtainAway = null;
function moveCurtainsOut(duration, startDelay) {
	if (moveLeftCurtainAway != null)
		moveLeftCurtainAway.cancel();
	if (moveRightCurtainAway != null)
		moveRightCurtainAway.cancel();

	moveLeftCurtainAway = game.tween(leftCurtain, {x: leftCurtain1}, duration, {ease: ease, startDelay: startDelay});
	moveRightCurtainAway = game.tween(rightCurtain, {x: rightCurtain1}, duration, {ease: ease, startDelay: startDelay});

	runCurtainCam(startDelay);
}

function onOpponentNoteHit(note) {
	if (note.strumTime > ANGRY_NOTES_START && note.strumTime < ANGRY_NOTES_END)
		updateBar(++angryNotesHit);
}

function updateBar(_) {
	jeffBar.value = 1 - ((angryNotesHit / angryNotes) * .75);
	final s = Math.min(jeffBar.text.scale.x * 1.2, 1.3);
	jeffBar.text.scale.set(s, s); 
	if (angryBump != null)
		angryBump.cancel();
	angryBump = game.tween(jeffBar.text.scale, {x: .75, y: .75}, stepTime(4), {ease: steppedEase(FlxEase.cubeOut, 4)});
}

var baseJeffOffset;
function onPauseUpdate(elapsed)
{
	if (game.curStep >= 2911 && game.curStep < 3135)
	{
		final jeff = game.pauseMenu.ostLeft.map.get("JEFF--1");
		if (baseJeffOffset == null)
			baseJeffOffset = [jeff.offset.x, jeff.offset.y];
		jeff.offset.set(baseJeffOffset[0] + FlxG.random.float(-5, 5), baseJeffOffset[1] + FlxG.random.float(-5, 5));
	}
}