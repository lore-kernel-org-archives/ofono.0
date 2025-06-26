Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB24A33
	for <ofono@lists.linux.dev>; Thu, 26 Jun 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960364; cv=none; b=kOUv60em3+l/NzhmukfxBXBPHjID8S/sMsQk6qO9gLTUhqdbk6D3jNDuojD1df8LvnmcE2kYIfmNYqDIToCfEvhKjNO7H8nXPZZmPza7dmdPE5AMWJO5sT2JawHQTVecY2V83j8ZrSp/PRBeIstIl43vN+dPP8VU+i+El4pMXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960364; c=relaxed/simple;
	bh=3yyLB8xFttyc5eua5dBzUpJGABasQ/p0R165ZOWPnig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVvnD5Lix6BNL7JpcVZx5r0P24JnaEmzFKre1kmWxpBxyZOco8kfmA1Ibm8a0fzJcE0jg9Sv6ihSigZ66w2eGY+TxJIfOi68cyjLeovl+scl+a4xI/QCJB6KWBAtvdGYF+72ve0F/sCrXFRFFktKhg10l9Q1zfGZd5Apb7Wt/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WqbRVh5R; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WqbRVh5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750960356; x=1751219556;
	bh=AhCkpHV7bxDXRoq3UwyPdD9ClkF0yDf+Lpls3ZdHstU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WqbRVh5RKeAMP91rhF/Oe0LXnvqXPlBR6ZfngexP75fNMSfDUlNcfIgLTeouEoje8
	 1hnyhbHISfiWZVjvblDpkt25FLK5EHoaODfbc/Sk0SrPnHeGAhfORmmzeqHrrHv0zl
	 OMl/ayArOnw9FEpd0pKCr5BY4hgfcVK+7PuJSYj0McUSQgC0SlmHzRkQHl4HCO8qkw
	 wbOK05EzydJ7NM70NMrog2bjxJix7oLWvxveu5bnti7mv2Xjeg3h/QWNxtCo8Zhd/o
	 oo0Qm6U0cYZN2ZO5cHWVsQtQCnPWA9zqycAcx2/NsA9K8eOGTfFpbjmSm14g8UtK/K
	 nvx7REsvrtyFw==
Date: Thu, 26 Jun 2025 17:52:31 +0000
To: Denis Kenzior <denkenz@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev
Subject: Re: [PATCH] qmi: avoid free of non heap object
Message-ID: <pxnmfjquo5ndcgwnl63g7u6qpa6gocx6kepw6pc4im7atkzbfh@pby3bj2niqid>
In-Reply-To: <3d248eee-86eb-4e92-bfbd-7b736545c0cb@gmail.com>
References: <20250626081625.1362728-1-sean@geanix.com> <3d248eee-86eb-4e92-bfbd-7b736545c0cb@gmail.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 0f2ded57cb2fe7517242b70a91c9d043253b5c77
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Jun 26, 2025 at 10:11:34AM +0100, Denis Kenzior wrote:
> Hi Sean,
>=20
> On 6/26/25 3:16 AM, Sean Nyekjaer wrote:
> > qmux_create_client_timeout() free's a non heap object, avoid calling
> > __request_free() and inline free_request() instead.
> >
> > In function 'l_free',
> >      inlined from '__request_free' at drivers/qmimodem/qmi.c:293:3,
> >      inlined from 'qmux_create_client_timeout' at drivers/qmimodem/qmi.=
c:1427:2:
> > ell/util.c:124:9: warning: 'free' called on pointer 'user_data_6(D)' wi=
th nonzero offset 28 [-Wfree-nonheap-object]
> >    124 |         free(ptr);
> >        |         ^
>=20
> Hmm, what tool is producing this output?

Good old gcc:
libtool: link: arm-oe-linux-gnueabi-gcc -mthumb -mfpu=3Dneon -mfloat-abi=3D=
hard -mcpu=3Dcortex-a7 -D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64 --sysroot=
=3D/usr/local/cc-sdk/sysroots/cortexa7t2hf-neon-oe-linux-gnueabi -I/usr/loc=
al/cc-sdk/sysroots/cortexa7t2hf-neon-oe-linux-gnueabi/usr/include/dbus-1.0 =
-I/usr/local/cc-sdk/sysroots/cortexa7t2hf-neon-oe-linux-gnueabi/usr/lib/dbu=
s-1.0/include -I/usr/local/cc-sdk/sysroots/cortexa7t2hf-neon-oe-linux-gnuea=
bi/usr/include/glib-2.0 -I/usr/local/cc-sdk/sysroots/cortexa7t2hf-neon-oe-l=
inux-gnueabi/usr/lib/glib-2.0/include -DOFONO_PLUGIN_BUILTIN -DPLUGINDIR=3D=
\"/usr/local/lib/ofono/plugins\" -DUNITDIR=3D\"./unit/\" -O2 -pipe -g -feli=
minate-unused-debug-types -flto -ffat-lto-objects -fuse-linker-plugin -O2 -=
U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -Wl,--export-dynamic -Wl,--version-s=
cript=3D./src/ofono.ver -Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-needed -o s=
rc/ofonod plugins/udevng.o src/rmnet.o drivers/qmimodem/qmi.o drivers/qmimo=
dem/nas.o drivers/qmimodem/wda.o drivers/qmimodem/wds.o drivers/qmimodem/de=
vinfo.o drivers/qmimodem/voicecall.o drivers/qmimodem/network-registration.=
o drivers/qmimodem/sim-legacy.o drivers/qmimodem/sim.o drivers/qmimodem/sms=
.o drivers/qmimodem/ussd.o drivers/qmimodem/gprs.o drivers/qmimodem/gprs-co=
ntext.o drivers/qmimodem/lte.o drivers/qmimodem/radio-settings.o drivers/qm=
imodem/location-reporting.o drivers/qmimodem/netmon.o drivers/qmimodem/call=
-settings.o drivers/qmimodem/call-barring.o drivers/qmimodem/call-forwardin=
g.o plugins/gobi.o plugins/qrtrqmi.o drivers/atmodem/call-settings.o driver=
s/atmodem/sms.o drivers/atmodem/cbs.o drivers/atmodem/call-forwarding.o dri=
vers/atmodem/call-meter.o drivers/atmodem/network-registration.o drivers/at=
modem/sim.o drivers/atmodem/stk.o drivers/atmodem/ussd.o drivers/atmodem/vo=
icecall.o drivers/atmodem/call-barring.o drivers/atmodem/phonebook.o driver=
s/atmodem/devinfo.o drivers/atmodem/call-volume.o drivers/atmodem/atutil.o =
drivers/atmodem/gprs.o drivers/atmodem/gprs-context.o drivers/atmodem/gnss.=
o drivers/atmodem/lte.o drivers/nwmodem/radio-settings.o drivers/swmodem/gp=
rs-context.o drivers/ztemodem/radio-settings.o drivers/iceramodem/gprs-cont=
ext.o drivers/iceramodem/radio-settings.o drivers/huaweimodem/ussd.o driver=
s/huaweimodem/voicecall.o drivers/huaweimodem/audio-settings.o drivers/huaw=
eimodem/gprs-context.o drivers/huaweimodem/radio-settings.o drivers/calypso=
modem/voicecall.o drivers/calypsomodem/stk.o drivers/mbmmodem/gprs-context.=
o drivers/mbmmodem/stk.o drivers/mbmmodem/location-reporting.o drivers/teli=
tmodem/location-reporting.o drivers/telitmodem/gprs-context-ncm.o drivers/h=
somodem/gprs-context.o drivers/hsomodem/radio-settings.o drivers/ifxmodem/v=
oicecall.o drivers/ifxmodem/audio-settings.o drivers/ifxmodem/radio-setting=
s.o drivers/ifxmodem/gprs-context.o drivers/ifxmodem/stk.o drivers/ifxmodem=
/ctm.o drivers/stemodem/stemodem.o drivers/stemodem/voicecall.o drivers/ste=
modem/radio-settings.o drivers/stemodem/caif_rtnl.o drivers/stemodem/gprs-c=
ontext.o drivers/dunmodem/network-registration.o drivers/dunmodem/gprs.o dr=
ivers/hfpmodem/slc.o drivers/hfpmodem/voicecall.o drivers/hfpmodem/network-=
registration.o drivers/hfpmodem/call-volume.o drivers/hfpmodem/devinfo.o dr=
ivers/hfpmodem/handsfree.o drivers/hfpmodem/siri.o drivers/speedupmodem/uss=
d.o drivers/ubloxmodem/ubloxmodem.o drivers/ubloxmodem/gprs-context.o drive=
rs/ubloxmodem/network-registration.o drivers/ubloxmodem/netmon.o drivers/ub=
loxmodem/lte.o drivers/gemaltomodem/location-reporting.o drivers/gemaltomod=
em/voicecall.o drivers/gemaltomodem/gprs-context.o drivers/gemaltomodem/rad=
io-settings.o drivers/gemaltomodem/netmon.o drivers/xmm7modem/radio-setting=
s.o drivers/xmm7modem/ims.o drivers/xmm7modem/netmon.o drivers/quectelmodem=
/radio-settings.o drivers/simcommodem/radio-settings.o plugins/g1.o plugins=
/wavecom.o plugins/calypso.o plugins/mbm.o plugins/hso.o plugins/zte.o plug=
ins/huawei.o plugins/sierra.o plugins/novatel.o plugins/palmpre.o plugins/i=
fx.o plugins/ste.o plugins/cinterion.o plugins/gemalto.o plugins/nokia.o pl=
ugins/linktop.o plugins/icera.o plugins/alcatel.o plugins/speedup.o plugins=
/samsung.o plugins/sim900.o plugins/sim7100.o plugins/telit.o plugins/quect=
el.o plugins/ublox.o plugins/xmm7xxx.o plugins/droid.o plugins/stemgr.o plu=
gins/connman.o plugins/hfp_hf_bluez5.o plugins/dun_gw_bluez5.o plugins/blue=
z5.o plugins/hfp_ag_bluez5.o plugins/upower.o plugins/smart-messaging.o plu=
gins/push-notification.o plugins/allowed-apns.o gatchat/gatchat.o gatchat/g=
atresult.o gatchat/gatsyntax.o gatchat/ringbuffer.o gatchat/gatio.o gatchat=
/crc-ccitt.o gatchat/gatmux.o gatchat/gsm0710.o gatchat/gattty.o gatchat/ga=
tutil.o gatchat/gatserver.o gatchat/gatrawip.o gatchat/gathdlc.o gatchat/ga=
tppp.o gatchat/ppp_cp.o gatchat/ppp_lcp.o gatchat/ppp_auth.o gatchat/ppp_ne=
t.o gatchat/ppp_ipcp.o gatchat/ppp_ipv6cp.o src/main.o src/log.o src/plugin=
.o src/modem.o src/common.o src/manager.o src/dbus.o src/util.o src/network=
.o src/voicecall.o src/ussd.o src/sms.o src/call-settings.o src/call-forwar=
ding.o src/call-meter.o src/smsutil.o src/call-barring.o src/sim.o src/stk.=
o src/phonebook.o src/history.o src/message-waiting.o src/simutil.o src/sto=
rage.o src/cbs.o src/watch.o src/call-volume.o src/gprs.o src/radio-setting=
s.o src/stkutil.o src/nettime.o src/stkagent.o src/simfs.o src/audio-settin=
gs.o src/smsagent.o src/ctm.o src/sim-auth.o src/message.o src/emulator.o s=
rc/location-reporting.o src/gnss.o src/gnssagent.o src/private-network.o sr=
c/handsfree.o src/handsfree-audio.o src/siri.o src/netmon.o src/lte.o src/i=
ms.o src/netmonagent.o src/module.o src/provisiondb.o src/provision.o  gdbu=
s/.libs/libgdbus-internal.a -ludev ell/.libs/libell-internal.a -lglib-2.0 -=
ldbus-1 -ldl
In function 'l_free',
    inlined from '__request_free' at drivers/qmimodem/qmi.c:293:3,
    inlined from 'qmux_create_client_timeout' at drivers/qmimodem/qmi.c:142=
7:2:
ell/util.c:124:9: warning: 'free' called on pointer 'user_data_6(D)' with n=
onzero offset 28 [-Wfree-nonheap-object]
  124 |         free(ptr);
      |         ^
>=20
> > ---
> >   drivers/qmimodem/qmi.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> > index 5d2553c5..4468761a 100644
> > --- a/drivers/qmimodem/qmi.c
> > +++ b/drivers/qmimodem/qmi.c
> > @@ -1424,7 +1424,9 @@ static void qmux_create_client_timeout(struct l_t=
imeout *timeout,
> >
> >   =09/* remove request from queues */
> >   =09find_control_request(qmux, req->super.tid);
> > -=09__request_free(&req->super);
> > +
> > +=09if (req->super.free_request)
> > +=09=09req->super.free_request(&req->super);
>=20
> This must be some sort of false positive.  In qmi_qmux_device_create_clie=
nt() we
> always set .free_request, so __request_free will never take the l_free() =
branch.
>=20
> The question is whether a compiler is producing this output or some stati=
c
> analysis tool?

Looks like it's because we are building with the lto enabled.

>=20
> >   }
> >
> >   static void qmux_create_client_callback(struct qmi_request *r,
>=20
> Regards,
> -Denis

/Sean

