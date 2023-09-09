Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AD1851
	for <ofono@lists.linux.dev>; Sat,  9 Sep 2023 16:35:04 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57124ee486dso1913031eaf.3
        for <ofono@lists.linux.dev>; Sat, 09 Sep 2023 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694277304; x=1694882104; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6RwEkH+BvJDnwV6V8mmCiwRt/KjlaGhvXqMI4sIHC4=;
        b=Ic76e0i1hnkeCZBd4fnBif2TPXPC6PzF5JyHCqtUzPsZQwK9EtHsyWRx7qbxKXnxqB
         UtPe2smvA+bb3AJjyLz9G0HemsQqaZnxp6xrl1hr67oAtZKAdXCwnKDrcEjpLyLh99OV
         MrcYxeY2mJce0dHCDCn3uNwuiJYPtkLbk8waavfo/DpIVXKCeV4P+RbAhSaLfn15y/bI
         FnOKz+wldCs5Hdi0Unup0KOg535DoNeeo2rIvnNAILwWHoFxLo+gQt1mZMOEzLqpkyDz
         /Ugg6hNHpm3i2N6oVxa2vAxfv1atLrGMYVgVpRbA3bMxMqRSLeQ1L86zUb2EfjfkdMZw
         RJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694277304; x=1694882104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6RwEkH+BvJDnwV6V8mmCiwRt/KjlaGhvXqMI4sIHC4=;
        b=acfZ53A8IK/DUr7hG9J8U0oBMuh50UdpHmirRUakvgdT1J/pILh3n7FXE0iPmCzOek
         FQrYOm7te+VbJ7qMD6bi0tAqGsrNVVtz/zcJ3p7tEMcxOlXAoIcSShjV1YQGSEHumUUj
         eOUt8/f34zKdtrOZswSJOIHuMzLsgiSG/Pn4ulV1Y7BQJvCNCbL3SIl6t19XinI3P762
         aWgLAGqlR+45o00uKc+j+9bc/d5/VinQTr2xUtndqSG0gNS1Fy1K3ufArFZxT8owKkRH
         p9PdFABABrzOKUfHVTM4WCLi4HRNcem6+VmZrqnrDcMngPctwhD4xKzDTdIbD/eq5BUc
         0txQ==
X-Gm-Message-State: AOJu0YwkKcCiWFJTlEKQyA/tHdGGOYTMNEk2n5FYumJPe2RkIN6TLWtc
	m7IZskODQT6ULMLHW6pwM5Nn9a8elp0f8KjZVxwKiTMvWvQ=
X-Google-Smtp-Source: AGHT+IHUCRJpIB0vKFHhAVBJ7/0YmBQa86Y0hdfHrZgmYbbUv5kEIlB8+W6fGZZqtsDhqLR6GLe0lsr69b5ZttkaRB0=
X-Received: by 2002:a05:6871:80b:b0:1b3:f010:87c2 with SMTP id
 q11-20020a056871080b00b001b3f01087c2mr6778817oap.30.1694277303403; Sat, 09
 Sep 2023 09:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAcv5+6TL4qU9N-CsVDjusG=p-c4ZL3LYQQdCZyLDA4TkvJn3Q@mail.gmail.com>
 <dc3b5e51-1b6e-f6e6-958b-0a6fba17d4a4@gmail.com> <CAAcv5+6kbVo9gn2BeKLPD534afXyj4mDwG_0VrTiT+0wWv1C8w@mail.gmail.com>
In-Reply-To: <CAAcv5+6kbVo9gn2BeKLPD534afXyj4mDwG_0VrTiT+0wWv1C8w@mail.gmail.com>
From: Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>
Date: Sat, 9 Sep 2023 17:34:51 +0100
Message-ID: <CAAcv5+4AwBvaZt=1O35Mrgc0gpeAsPsAOL_gNE_BuDO4V+hHaQ@mail.gmail.com>
Subject: Re: LET context deactivation
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I upgraded to ofono 1.32 and connman 1.40, I also did the following
patch in order to activate/desactivate lte context manually and break
the dependency between attached and context activation otherwise I get
gprs not attached error while activating lte context

@ -1619,21 +1619,10 @@ static gboolean on_lte(struct ofono_gprs *gprs)
 static void gprs_attached_update(struct ofono_gprs *gprs)
 {
  ofono_bool_t attached;
  int status =3D gprs->status;

- if (on_lte(gprs))
- /*
- * For LTE we attached status reflects successful context
- * activation.
- * Since we in gprs_netreg_update not even try to attach
- * to GPRS if we are running on LTE, we can on some modems
- * expect the gprs status to be unknown. That must not
- * result in detaching...
- */
- attached =3D have_active_contexts(gprs);
- else
  attached =3D gprs->driver_attached &&
  (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
  status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);

  if (attached =3D=3D gprs->attached)
@@ -1646,11 +1635,11 @@ static void gprs_attached_update(struct
ofono_gprs *gprs)
  * Active contexts have to be release at driver level.
  *
  * Skip that for LTE since the condition to be attached on LTE
  * is that a context gets activated
  */
- if (have_detachable_active_contexts(gprs) && !on_lte(gprs)) {
+ if (have_detachable_active_contexts(gprs)) {
  detach_active_contexts(gprs);

  if (attached =3D=3D TRUE) {
  /*
  * Some times the context activates after a detach event
@@ -1743,22 +1732,10 @@ static void gprs_netreg_update(struct ofono_gprs *g=
prs)

  attach =3D attach && gprs->powered;

  DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);

- if (on_lte(gprs)) {
- /*
- * For LTE we set attached status only on successful
- * context activation.
- *
- * The context could potentially be registered before the
- * netreg update is received.
- */
- gprs_attached_update(gprs);
- return;
- }
-
  if (gprs->driver_attached =3D=3D attach)
  return;

  if (gprs->flags & GPRS_FLAG_ATTACHING) {
  gprs->flags |=3D GPRS_FLAG_RECHECK;
@@ -2778,11 +2755,11 @@ void ofono_gprs_context_deactivated(struct
ofono_gprs_context *gc,
  * to registered applications after active contexts have been released.
  *
  * "Attached" could also change to FALSE in case of LTE and getting
  * deactivated
  */
- if (on_lte(gprs) || gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
+ if (gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
  gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
  gprs_attached_update(gprs);
  }
 }

Best regards
Mohamed Ali

Le ven. 8 sept. 2023 =C3=A0 19:23, Mohamed Ali Fodha
<fodha.mohamed.ali@gmail.com> a =C3=A9crit :
>
> Hi Denis,
>
> I am using connman 1.37 with following main.conf:
> root@raspberrypi0-wifi:~# cat /etc/connman/main.conf
> [General]
> NetworkInterfaceBlacklist=3Deth0,wlan0
> DefaultAutoConnectTechnologies=3Dethernet,wifi
>
> Please find below the logs:
>
> root@raspberrypi0-wifi:~# ofonod[505]: oFono version 1.31
> ofonod[505]: ../ofono-1.31/src/plugin.c:__ofono_plugin_init()
> ofonod[505]: ../ofono-1.31/src/gprs-provision.c:ofono_gprs_provision_driv=
er_register()
> driver: 0x610540 name: GPRS context provisioning
> ofonod[505]: ../ofono-1.31/plugins/push-notification.c:push_notification_=
init()
> ofonod[505]: ../ofono-1.31/plugins/smart-messaging.c:smart_messaging_init=
()
> ofonod[505]: ../ofono-1.31/src/cdma-provision.c:ofono_cdma_provision_driv=
er_register()
> driver: 0x610514 name: CDMA provisioning
> ofonod[505]: ../ofono-1.31/src/gprs-provision.c:ofono_gprs_provision_driv=
er_register()
> driver: 0x6104e8 name: Provisioning
> ofonod[505]: ../ofono-1.31/plugins/upower.c:upower_init() upower init
> ofonod[505]: ../ofono-1.31/src/handsfree-audio.c:ofono_handsfree_card_dri=
ver_register()
> driver: 0x610494
> ofonod[505]: ../ofono-1.31/plugins/dun_gw_bluez5.c:dun_gw_init()
> ofonod[505]: ../ofono-1.31/src/handsfree-audio.c:ofono_handsfree_card_dri=
ver_register()
> driver: 0x6103f8
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x61040c, name: hfp
> ofonod[505]: ../ofono-1.31/plugins/xmm7xxx.c:xmm7xxx_init()
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x6103a0, name: xmm7xxx
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x610350, name: ublox
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x6102d8, name: quectel
> ofonod[505]: ../ofono-1.31/plugins/telit.c:telit_init()
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x610288, name: telit
> ofonod[505]: ../ofono-1.31/plugins/connman.c:connman_init()
> ofonod[505]: ../ofono-1.31/src/private-network.c:ofono_private_network_dr=
iver_register()
> driver: 0x61025c, name: ConnMan Private Network
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x610214, name: sim7100
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x6101cc, name: sim900
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x610184, name: samsung
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x61013c, name: speedupcdma
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x6100ec, name: speedup
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x6100a4, name: alcatel
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x61004c, name: icera
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x610004, name: linktop
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60ffbc, name: nokiacdma
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60ff74, name: nokia
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60ff1c, name: gemalto
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fed4, name: cinterion
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fe4c, name: ste
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fdf4, name: ifx
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fdac, name: palmpre
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fd5c, name: novatel
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fd14, name: sierra
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fc9c, name: huawei
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fc54, name: zte
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fbf4, name: hso
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fba4, name: mbm
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fb54, name: calypso
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fb0c, name: wavecom
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fac4, name: g1
> ofonod[505]: ../ofono-1.31/src/cdma-voicecall.c:ofono_cdma_voicecall_driv=
er_register()
> driver: 0x60b598, name: cdmamodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60b5b8, name: cdmamodem
> ofonod[505]: ../ofono-1.31/src/cdma-connman.c:ofono_cdma_connman_driver_r=
egister()
> driver: 0x60b5d8, name: cdmamodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fa1c, name: phonesim
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60fa4c, name: localhfp
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60fa00, name: phonesim
> ofonod[505]: ../ofono-1.31/src/ctm.c:ofono_ctm_driver_register()
> driver: 0x60f9ec, name: phonesim
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60f9c4, name: phonesim
> ofonod[505]: ../ofono-1.31/plugins/phonesim.c:parse_config() filename
> /etc/ofono/phonesim.conf
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60b540, name: xmm7modem
> ofonod[505]: ../ofono-1.31/src/ims.c:ofono_ims_driver_register()
> driver: 0x60b568, name: xmm7modem
> ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
> driver: 0x60b580, name: xmm7modem
> ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_report=
ing_driver_register()
> driver: 0x60b4d8, name: gemaltomodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60b4f0, name: gemaltomodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b494, name: ubloxmodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60e480, name: ubloxmodem
> ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
> driver: 0x60b4b0, name: ubloxmodem
> ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
> driver: 0x60b4c8, name: ubloxmodem
> ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
> driver: 0x60b418, name: speedupmodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60b33c, name: hfpmodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60b3c8, name: hfpmodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60b38c, name: hfpmodem
> ofonod[505]: ../ofono-1.31/src/call-volume.c:ofono_call_volume_driver_reg=
ister()
> driver: 0x60b3b0, name: hfpmodem
> ofonod[505]: ../ofono-1.31/src/handsfree.c:ofono_handsfree_driver_registe=
r()
> driver: 0x60b3e8, name: hfpmodem
> ofonod[505]: ../ofono-1.31/src/siri.c:ofono_siri_driver_register()
> driver: 0x60b408, name: hfpmodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60b300, name: dunmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
> driver: 0x60b324, name: dunmodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60b26c, name: stemodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b2e4, name: stemodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60b2bc, name: stemodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60b1a0, name: ifxmodem
> ofonod[505]: ../ofono-1.31/src/audio-settings.c:ofono_audio_settings_driv=
er_register()
> driver: 0x60b1f0, name: ifxmodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60b1fc, name: ifxmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b224, name: ifxmodem
> ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
> driver: 0x60b240, name: ifxmodem
> ofonod[505]: ../ofono-1.31/src/ctm.c:ofono_ctm_driver_register()
> driver: 0x60b258, name: ifxmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b15c, name: hsomodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60b178, name: hsomodem
> ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_report=
ing_driver_register()
> driver: 0x60b128, name: telitmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b140, name: telitncmmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b0dc, name: mbmmodem
> ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
> driver: 0x60b0f8, name: mbmmodem
> ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_report=
ing_driver_register()
> driver: 0x60b110, name: mbmmodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60b074, name: calypsomodem
> ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
> driver: 0x60b0c4, name: calypsomodem
> ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
> driver: 0x60afb0, name: huaweimodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60afc4, name: huaweimodem
> ofonod[505]: ../ofono-1.31/src/audio-settings.c:ofono_audio_settings_driv=
er_register()
> driver: 0x60b014, name: huaweimodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60b03c, name: huaweimodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60b020, name: huaweimodem
> ofonod[505]: ../ofono-1.31/src/cdma-netreg.c:ofono_cdma_netreg_driver_reg=
ister()
> driver: 0x60b064, name: huaweimodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60af6c, name: iceramodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60af88, name: iceramodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60af44, name: ztemodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60af28, name: swmodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60af00, name: nwmodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60adf8, name: atmodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60ae70, name: atmodem
> ofonod[505]: ../ofono-1.31/src/call-barring.c:ofono_call_barring_driver_r=
egister()
> driver: 0x60ae48, name: atmodem
> ofonod[505]: ../ofono-1.31/src/call-forwarding.c:ofono_call_forwarding_dr=
iver_register()
> driver: 0x60abec, name: atmodem
> ofonod[505]: ../ofono-1.31/src/call-meter.c:ofono_call_meter_driver_regis=
ter()
> driver: 0x60ac0c, name: atmodem
> ofonod[505]: ../ofono-1.31/src/call-settings.c:ofono_call_settings_driver=
_register()
> driver: 0x60ab74, name: atmodem
> ofonod[505]: ../ofono-1.31/src/phonebook.c:ofono_phonebook_driver_registe=
r()
> driver: 0x60ae60, name: atmodem
> ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
> driver: 0x60ade4, name: atmodem
> ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
> driver: 0x60abb8, name: atmodem
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60acfc, name: atmodem
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60ad64, name: atmodem-noef
> ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
> driver: 0x60adcc, name: atmodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60ac34, name: atmodem
> ofonod[505]: ../ofono-1.31/src/cbs.c:ofono_cbs_driver_register()
> driver: 0x60abd8, name: atmodem
> ofonod[505]: ../ofono-1.31/src/call-volume.c:ofono_call_volume_driver_reg=
ister()
> driver: 0x60ae90, name: atmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
> driver: 0x60aea8, name: atmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60aec0, name: atmodem
> ofonod[505]: ../ofono-1.31/src/gnss.c:ofono_gnss_driver_register()
> driver: 0x60aedc, name: atmodem
> ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
> driver: 0x60aef0, name: atmodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f2f0, name: mbim
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60aa74, name: mbim
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60aa94, name: mbim
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60aafc, name: mbim
> ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
> driver: 0x60ab20, name: mbim
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
> driver: 0x60ab40, name: mbim
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60ab58, name: mbim
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f288, name: gobi
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60a840, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60a8b0, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60a860, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60a8d4, name: qmimodem-legacy
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60a93c, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
> driver: 0x60a9a4, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
> driver: 0x60a9c4, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
> driver: 0x60a9d8, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60a9f0, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
> driver: 0x60aa0c, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60aa1c, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_report=
ing_driver_register()
> driver: 0x60aa44, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
> driver: 0x60aa5c, name: qmimodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f220, name: u8500
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60f200, name: u8500
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f1b8, name: n900
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f170, name: isiusb
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60a324, name: isimodem
> ofonod[505]: ../ofono-1.31/src/phonebook.c:ofono_phonebook_driver_registe=
r()
> driver: 0x60a314, name: isimodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60a344, name: isimodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60a368, name: isimodem
> ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
> driver: 0x60a3b8, name: isimodem
> ofonod[505]: ../ofono-1.31/src/cbs.c:ofono_cbs_driver_register()
> driver: 0x60a3d8, name: isimodem
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60a3ec, name: isimodem
> ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
> driver: 0x60a454, name: isimodem
> ofonod[505]: ../ofono-1.31/src/call-forwarding.c:ofono_call_forwarding_dr=
iver_register()
> driver: 0x60a468, name: isimodem
> ofonod[505]: ../ofono-1.31/src/call-settings.c:ofono_call_settings_driver=
_register()
> driver: 0x60a488, name: isimodem
> ofonod[505]: ../ofono-1.31/src/call-barring.c:ofono_call_barring_driver_r=
egister()
> driver: 0x60a4b8, name: isimodem
> ofonod[505]: ../ofono-1.31/src/call-meter.c:ofono_call_meter_driver_regis=
ter()
> driver: 0x60a4d0, name: isimodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60a4f8, name: isimodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
> driver: 0x60a520, name: isimodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60a538, name: isimodem
> ofonod[505]: ../ofono-1.31/src/audio-settings.c:ofono_audio_settings_driv=
er_register()
> driver: 0x60a554, name: isimodem
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60a560, name: wgmodem2.5
> ofonod[505]: ../ofono-1.31/drivers/rilmodem/rilmodem.c:rilmodem_init()
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x60a04c, name: rilmodem
> ofonod[505]: ../ofono-1.31/drivers/rilmodem/sim.c:ril_sim_init()
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
> driver: 0x60a150, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_registe=
r()
> driver: 0x60a090, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
> driver: 0x60a1b8, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
> driver: 0x60a06c, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/call-volume.c:ofono_call_volume_driver_reg=
ister()
> driver: 0x60a0e0, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
> driver: 0x60a0f8, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register(=
)
> driver: 0x60a110, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
> driver: 0x60a1d8, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/call-settings.c:ofono_call_settings_driver=
_register()
> driver: 0x60a1ec, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/call-forwarding.c:ofono_call_forwarding_dr=
iver_register()
> driver: 0x60a21c, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driv=
er_register()
> driver: 0x60a23c, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/call-barring.c:ofono_call_barring_driver_r=
egister()
> driver: 0x60a264, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
> driver: 0x60a27c, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
> driver: 0x60a294, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/cbs.c:ofono_cbs_driver_register()
> driver: 0x60a2ac, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
> driver: 0x60a2c0, name: rilmodem
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f0e8, name: ril_intel
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f0a0, name: infineon
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
> driver: 0x60f058, name: ril
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:udev_start()
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:enumerate_devices()
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() hub [1d6b:=
0002]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() usb [1d6b:=
0002]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() usb [1a40:=
0101]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.0/ttyUSB0/t=
ty/ttyUSB0
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB0
> (sim7x00) 255/255/255 [00] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.1/ttyUSB1/t=
ty/ttyUSB1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB1
> (sim7x00) 255/0/0 [01] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.2/ttyUSB2/t=
ty/ttyUSB2
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB2
> (sim7x00) 255/0/0 [02] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.3/ttyUSB3/t=
ty/ttyUSB3
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB3
> (sim7x00) 255/0/0 [03] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
> [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.4/ttyUSB4/t=
ty/ttyUSB4
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB4
> (sim7x00) 255/0/0 [04] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device()
> qmi_wwan [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device()
> qmi_wwan [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.5/net/wwan0
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() wwan0
> (sim7x00) 255/255/255 [05] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device()
> qmi_wwan [1e0e:9001]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.5/usbmisc/c=
dc-wdm0
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/cdc-wdm0
> (sim7x00) 255/255/255 [05] =3D=3D> (null) (null)
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() hub [1a40:=
0101]
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono[  305.126450] Bluetooth: RFCOMM TTY layer initializ=
ed
> -1.31/plugins/udevng.c:add_serial_device() Device is missing required
> OFONO_DRIV[  305.138271] Bluetooth: RFCOMM socket layer initialized
> ER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Dev[
> 305.151127] Bluetooth: RFCOMM ver 1.11
> ice is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
> is missing required OFONO_DRIVER property
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:create_modem()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:create_modem() driver=3Dsim7x=
00
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_create() name:
> (null), type: sim7x00
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /dev/ttyUSB0 255/255/255 00 (null) (null) tty
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /dev/ttyUSB1 255/0/0 01 (null) (null) tty
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /dev/ttyUSB2 255/0/0 02 (null) (null) tty
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /dev/ttyUSB3 255/0/0 03 (null) (null) tty
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /dev/ttyUSB4 255/0/0 04 (null) (null) tty
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> /dev/cdc-wdm0 255/255/255 05 (null) (null) usbmisc
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00() wwan0
> 255/255/255 05 (null) (null) net
> ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
> qmi=3D/dev/cdc-wdm0 net=3Dwwan0 mdm=3D/dev/ttyUSB2 gps=3D/dev/ttyUSB1
> diag=3D/dev/ttyUSB0
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_set_driver() type: gob=
i
> ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
> 0x19f5730 property Device
> ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
> 0x19f5730 property Modem
> ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
> 0x19f5730 property NetworkInterface
> ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
> 0x19f5730 property GPS
> ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
> 0x19f5730 property Diag
> ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
> 0x19f5730 property SystemPath
> ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_register() 0x19f5730
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_probe() 0x19f5730
> ofonod[505]: ../ofono-1.31/src/modem.c:emit_modem_added() 0x19f5730
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property SystemPath
> ofonod[505]: ../ofono-1.31/src/modem.c:call_modemwatches() 0x19f5730 adde=
d:1
> ofonod[505]: ../ofono-1.31/plugins/dun_gw_bluez5.c:modem_watch()
> modem: 0x19f5730, added: 1
> ofonod[505]: ../ofono-1.31/plugins/hfp_ag_bluez5.c:modem_watch()
> modem: 0x19f5730, added: 1
> ofonod[505]: ../ofono-1.31/plugins/smart-messaging.c:modem_watch()
> modem: 0x19f5730, added: 1
> ofonod[505]: ../ofono-1.31/plugins/push-notification.c:modem_watch()
> modem: 0x19f5730, added: 1
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property SystemPath
> ofonod[505]: ../ofono-1.31/plugins/hfp_hf_bluez5.c:connect_handler()
> Registering External Profile handler ...
> ofonod[505]: ../ofono-1.31/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 0000111e-0000-1000-8000-00805f9b34fb (hfp_hf)
> profile
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_enable() 0x19f5730
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property Device
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:discover_cb()
> ofonod[505]: ../ofono-1.31/plugins/bluez5.c:profile_register_cb()
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:create_dms_cb()
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb()
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() service capabilit=
ies 4
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() sim supported 2
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() radio =3D 4
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() radio =3D 5
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() radio =3D 8
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_oper_mode_cb()
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property AlwaysOnline
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:power_reset_cb()
> ofonod[505]: ../ofono-1.31/src/modem.c:modem_change_state() old state:
> 0, new state: 1
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_pre_sim() 0x19f5730
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_devinfo_probe()
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property ForceSimLegacy
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_sim_probe()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/voicecall.c:qmi_voicecall_pro=
be()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:create_dms_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_caps()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:create_dms_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/voicecall.c:create_voice_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:get_caps_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_manufactu=
rer()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:create_uim_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:string_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_model()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:event_registration_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:event_registration_cb()
> event mask 0x0003
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:string_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_revision(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_card_status_cb()
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb=
0
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb=
0
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb=
0
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb=
0
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb=
0
> ofonod[505]: Interface org.ofono.AllowedAccessPoints not found on the
> interface_list
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:string_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_serial()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: Requested file structure differs from SIM: 6fb7
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g2_read_cb() 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:get_ids_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6fb7 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x2fe2 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x2fe2 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
> bufoff: 0, dataoff: 0, tocopy: 10
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f05 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x6f05 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
> bufoff: 0, dataoff: 0, tocopy: 20
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x2f05 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x2f05 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
> bufoff: 0, dataoff: 0, tocopy: 16
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_query_passwd_state(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:query_passwd_state_cb()
> passwd state 0
> ofonod[505]: ../ofono-1.31/src/sim.c:sim_pin_query_cb() sim->pin_type:
> 0, pin_type: 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_query_pin_retries()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6fae path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6fad path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:query_pin_retries_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x6fad path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
> bufoff: 0, dataoff: 0, tocopy: 4
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f16 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f38 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x6f38 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
> bufoff: 0, dataoff: 0, tocopy: 13
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f56 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x6f56 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
> bufoff: 0, dataoff: 0, tocopy: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_imsi()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_imsi_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
> file id 0x6f07 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag)
> profile
> ofonod[505]: ../ofono-1.31/src/modem.c:modem_change_state() old state:
> 1, new state: 2
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_post_sim() 0x19f5730
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:qmimodem_lte_probe()
> qmimodem lte probe
> ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_create() LTE atom created
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:qmi_radio_se=
ttings_probe()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:qmi_sms_probe()
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property ForceSimLegacy
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property AlwaysOnline
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:create_dms_c=
b()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6fca path len 0
> ofonod[505]: ../ofono-1.31/plugins/bluez5.c:profile_register_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:create_wds_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:create_nas_c=
b()
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:radio_load_settings()
> TechnologyPreference: 0
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:radio_load_settings() Gsm=
Band: 0
> ofonod[505]: ../ofono-1.31/src/radio-settings.c:radio_load_settings()
> UmtsBand: 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:qmi_set_rat_=
mode()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:create_wms_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: Unable to read waiting messages numbers from SIM
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6fc9 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:get_default_profile_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:get_default_profile_cb(=
)
> Default profile index: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:set_system_s=
election_pref_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:set_event_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: Unable to read mailbox identifies from SIM
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f11 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:reset_profile_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:qmimodem_lte_set_defaul=
t_attach_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() found 6=
 routes
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
> 0 class 0 =3D> type 1 value 3
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
> 0 class 1 =3D> type 1 value 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
> 0 class 2 =3D> type 0 value 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
> 0 class 3 =3D> type 1 value 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
> 0 class 4 =3D> type 1 value 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
> 0 class 5 =3D> type 1 value 3
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb()
> transfer status report 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/src/message-waiting.c:mw_cphs_mwis_read_cb()
> No CPHS MWIS on SIM
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f40 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:modify_profile_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:set_routes_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:qmi_bearer_set() bearer=
 3
> ofonod[505]: ../ofono-1.31/src/sms.c:sms_restore_tx_queue()
> ofonod[505]: ../ofono-1.31/plugins/push-notification.c:sms_watch() regist=
ered
> ofonod[505]: ../ofono-1.31/plugins/smart-messaging.c:sms_watch() register=
ed
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
> msg tag 0 mode 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
> msg tag 2 mode 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
> msg tag 0 mode 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
> msg tag 2 mode 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_protocol()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6f40 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:set_domain_pref_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_protocol_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_protocol_cb()
> device supports CDMA and WCDMA msg protocol
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
> file id 0x6f40 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb()
> Err: get msg list mode=3D0 47=3DUNKNOWN
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x4f20 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb() msgs =
found 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
>
> root@raspberrypi0-wifi:~# dbus-send --system --type=3Dmethod_call
> --print-reply --dest=3Dorg.ofono /sim7x00_0 org.ofono.Modem.SetProperty
> string:"Online" variant:boolean:true
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property AlwaysOnline
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_set_online() 0x19f5730 onl=
ine
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:set_online_cb()
> method return time=3D1600598956.298364 sender=3D:1.9 -> destination=3D:1.=
11
> serial=3D55 reply_serial=3D2
> ofonod[505]: ../ofono-1.31/src/modem.c:modem_change_state() old state:
> 2, new state: 3
> ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_post_online() 0x19f5730
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_ne=
treg_probe()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/netmon.c:qmi_netmon_probe()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/ussd.c:qmi_ussd_probe()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:qmi_gprs_probe()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_gprs_conte=
xt_probe()
> root@raspberrypi0-wifi:~# ofonod[505]:
> ../ofono-1.31/drivers/qmimodem/network-registration.c:create_nas_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/netmon.c:create_nas_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/ussd.c:create_voice_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:create_nas_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:create_wds_cb()
> ofonod[505]: ../ofono-1.31/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw)
> profile
> ofonod[505]: ../ofono-1.31/plugins/bluez5.c:profile_register_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:create_wda_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:set_ev=
ent_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_re=
gistration_status()
> ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_spn_watch() 0x19f4fb0
> ofonod[505]: ../ofono-1.31/src/network.c:__ofono_netreg_add_status_watch(=
)
> 0x1a11918
> ofonod[505]: ../ofono-1.31/src/network.c:__ofono_netreg_add_status_watch(=
)
> 0x1a11918
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 0
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status unregistered (0)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_detached_notify() /sim7x=
00_0
> ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block() bufoff:
> 0, seekoff: 39, toread: 17
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_data_forma=
t_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_data_forma=
t_cb()
> expected data set to raw-ip
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:create_wds_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_ss=
_info_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 2
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 2 lac -1 cellid -1 tech -1
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 2 tech -1 lac -1 ci -1
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, (nil)
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 2 (searchin=
g)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
> file id 0x6f15 path len 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb(=
)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status unregistered (0)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_detached_notify() /sim7x=
00_0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_inf=
o_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 2
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> 60502 (605:02)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 2 lac -1 cellid -1 tech 7
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 2 tech 7 lac -1 ci -1
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, (nil)
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 2 (searchin=
g)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> rat 8 band 145 channel 6200
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> signal with 40%(-80 dBm) on 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params(=
)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status registered (1)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_inf=
o_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> 60502 (605:02)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 0 lac 65534 cellid 11038465 tech 7
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 1 tech 7 lac 65534 ci 11038465
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_cu=
rrent_operator()
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, (nil)
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (register=
ed)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_si=
gnal_strength()
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (register=
ed)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> rat 8 band 145 channel 6200
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb=
()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb=
()
> Default profile index: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params(=
)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status registered (1)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_inf=
o_notify()
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_time_notify()
> net time 2023-09-08 18:05:31 utcoff 3600 dst 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 2 lac -1 cellid -1 tech 7
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 1 tech 7 lac 65534 ci 11038465
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_cu=
rrent_operator()
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, 0x19fb200
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_si=
gnal_strength()
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (register=
ed)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> signal with -80 dBm on 8
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_strength_notify()
> strength 40
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_param_c=
b()
> ofonod[505]: LTE attach IP type: 0
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_cid_activated() cid 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_gprs_read_=
settings()
> cid 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> signal with -80 dBm on 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
> packet handle -2031133168
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> conn status 2
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> ip family 4
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> PDP type 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> IP addr: 102.27.72.156
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Gateway: 102.27.72.157
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Gateway netmask: 255.255.255.248
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Primary DNS: 196.203.82.66
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Secondary DNS: 8.8.4.4
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property NetworkInterface
> ofonod[505]: ../ofono-1.31/src/gprs.c:pri_read_settings_callback() 0x1a0d=
c08
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params(=
)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status registered (1)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_inf=
o_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 2 lac -1 cellid 11038468 tech 7
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 1 tech 7 lac 65534 ci 11038468
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_cu=
rrent_operator()
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, 0x19fb200
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_si=
gnal_strength()
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (register=
ed)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> rat 8 band 145 channel 1350
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> signal with -80 dBm on 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> signal with 20%(-86 dBm) on 8
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_strength_notify()
> strength 20
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status unregistered (0)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_detached_notify() /sim7x=
00_0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_inf=
o_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 2 lac -1 cellid -1 tech 7
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 1 tech 7 lac 65534 ci 11038468
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_cu=
rrent_operator()
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, 0x19fb200
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_si=
gnal_strength()
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (register=
ed)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params(=
)
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
> /sim7x00_0 status registered (1)
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_inf=
o_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> serving system status 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> radio in use 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extrac=
t_ss_info()
> roaming 2 lac -1 cellid -1 tech 7
> ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
> /sim7x00_0 status 1 tech 7 lac 65534 ci 11038468
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_cu=
rrent_operator()
> ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
> 0x1a11918, 0x19fb200
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_si=
gnal_strength()
> ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (register=
ed)
> ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_=
notify()
> rat 8 band 122 channel 1350
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> signal with -86 dBm on 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb=
()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb=
()
> Default profile index: 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rs=
si_cb()
> signal with -86 dBm on 8
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_param_c=
b()
> ofonod[505]: LTE attach IP type: 0
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_cid_activated() cid 1
> ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_cid_activated() cid 1
> already activated
>
> root@raspberrypi0-wifi:~# dbus-send --system --print-reply
> --dest=3Dorg.ofono /sim7x00_0 org.ofono.ConnectionManager.GetContexts
> method return time=3D1600598975.327997 sender=3D:1.9 -> destination=3D:1.=
12
> serial=3D82 reply_serial=3D2
>    array [
>       struct {
>          object path "/sim7x00_0/context1"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean true
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string "internet.tn"
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "AuthenticationMethod"
>                variant                   string "chap"
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                      dict entry(
>                         string "Interface"
>                         variant                            string "wwan0"
>                      )
>                      dict entry(
>                         string "Method"
>                         variant                            string "static=
"
>                      )
>                      dict entry(
>                         string "Address"
>                         variant                            string
> "102.27.72.156"
>                      )
>                      dict entry(
>                         string "Netmask"
>                         variant                            string
> "255.255.255.248"
>                      )
>                      dict entry(
>                         string "Gateway"
>                         variant                            string
> "102.27.72.157"
>                      )
>                      dict entry(
>                         string "DomainNameServers"
>                         variant                            array [
>                               string "196.203.82.66"
>                               string "8.8.4.4"
>                            ]
>                      )
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>    ]
> root@raspberrypi0-wifi:~# dbus-send --system --type=3Dmethod_call
> --print-reply --dest=3Dorg.ofono /sim7x00_0/context1
> org.ofono.ConnectionContext.SetProperty string:"Active"
> variant:boolean:false
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_deactivate=
_primary()
> cid 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:stop_net_cb()
> method return time=3D1600598979.752358 sender=3D:1.9 -> destination=3D:1.=
13
> serial=3D83 reply_serial=3D2
> root@raspberrypi0-wifi:~# ofonod[505]:
> ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> conn status 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> ip family 4
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_activate_p=
rimary()
> cid 1
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
> packet handle -2031133168
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> conn status 2
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_not=
ify()
> ip family 4
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> PDP type 0
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> IP addr: 102.27.72.156
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Gateway: 102.27.72.157
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Gateway netmask: 255.255.255.248
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Primary DNS: 196.203.82.66
> ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_c=
b()
> Secondary DNS: 8.8.4.4
> ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
> 0x19f5730 property NetworkInterface
> ofonod[505]: ../ofono-1.31/src/gprs.c:pri_activate_callback() 0x1a0dc08
>
> root@raspberrypi0-wifi:~# dbus-send --system --print-reply
> --dest=3Dorg.ofono /sim7x00_0 org.ofono.ConnectionManager.GetContexts
> method return time=3D1600598993.138198 sender=3D:1.9 -> destination=3D:1.=
14
> serial=3D89 reply_serial=3D2
>    array [
>       struct {
>          object path "/sim7x00_0/context1"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean true
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string "internet.tn"
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "AuthenticationMethod"
>                variant                   string "chap"
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                      dict entry(
>                         string "Interface"
>                         variant                            string "wwan0"
>                      )
>                      dict entry(
>                         string "Method"
>                         variant                            string "static=
"
>                      )
>                      dict entry(
>                         string "Address"
>                         variant                            string
> "102.27.72.156"
>                      )
>                      dict entry(
>                         string "Netmask"
>                         variant                            string
> "255.255.255.248"
>                      )
>                      dict entry(
>                         string "Gateway"
>                         variant                            string
> "102.27.72.157"
>                      )
>                      dict entry(
>                         string "DomainNameServers"
>                         variant                            array [
>                               string "196.203.82.66"
>                               string "8.8.4.4"
>                            ]
>                      )
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>    ]
>
> Bestregards,
> Mohamed Ali
>
> Le ven. 8 sept. 2023 =C3=A0 03:24, Denis Kenzior <denkenz@gmail.com> a =
=C3=A9crit :
> >
> > Hi Mohamed,
> >
> > On 9/7/23 11:49, Mohamed Ali Fodha wrote:
> > > Hello,
> > >
> > > I am using SIM7600 chip with ofono 1.31, when I set Online to true,
> > > the internet context is activated and it is not possible to deactivat=
e
> > > it at all using the following command:
> >
> > Note that on LTE the default bearer is activated when registering to th=
e
> > network.  One context always exists while registered to LTE.
> >
> > >
> > > dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.of=
ono
> > > /csim7x00_0/context1 org.ofono.ConnectionContext.SetProperty
> > > string:"Active" variant:boolean:false
> > >
> > > According to the log I saw always activate_primary which is
> > > automatically called after above command.
> >
> > Are you running connman or something else along side oFono? Sounds like
> > something is setting the context back up.
> >
> > >
> > > Any idea how to disable the automatic LTE context which is created?
> > >
> >
> > Hard to answer this without more context / info / logs.
> >
> > Regards,
> > -Denis
> >
