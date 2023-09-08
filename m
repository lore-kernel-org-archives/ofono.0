Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA314A9C
	for <ofono@lists.linux.dev>; Fri,  8 Sep 2023 18:24:12 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-573921661a6so1435681eaf.1
        for <ofono@lists.linux.dev>; Fri, 08 Sep 2023 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694197452; x=1694802252; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr26qHhd3ibZqSs8neuW2lU1IhuoCBpJ862FB2mnXL8=;
        b=pLDXlFP30cnbj3/Mv7Fo7ZY+VrlIx7EIf+EQpvKIz/n0gCqFTRaEgswE7MvDnLqjLl
         fpM37pO7rZEIx/jYpCrC3XGjBCK6+wK4FjcGYW2r96XKZlV+gh5M8LoXgq/pxKOw6rUs
         TBxBeYDIUx1Vgy3qK8ZVyc8mG42aNRWTs0y4AlJH9cTgj9Ry9I5EYmY74j2cEpiNivBW
         qqnVZ5igl9COnOg9QGl7XHjbOVgdr2apE0u1mYvpz9MnZowBJ2cxRKA6bkMjGhYdAfep
         iWfJ2TNu62zdgEk8BZoBJvmhzURfApKKsdVyaSaUnZK/7QGTfTssDDLwqhp1q9SCUKZv
         yxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694197452; x=1694802252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr26qHhd3ibZqSs8neuW2lU1IhuoCBpJ862FB2mnXL8=;
        b=O3254sTYAIy0t5w21yc2Jn4o1zts/5bezp+67N5eQEh8IeCx6rbMbwfizqtfofiDnl
         t38w8RsM9c80NrLLc3Wp6KIIMjxuAu3n4tS9fGJirxo1epi6F3k4mU67oj6jusrRaeoY
         uakx6lKz2RGlF6y1LxHGqD/mbnPl7ZcY02h9j41E9UaRYeILHA2oE/o7Q6JOCcLSny6Z
         Kph0mRhuqCxZIEyZt5FlgyPpWNCxholnnRQbE2eyzYehIHyAcD6lzPObmOtwp5lAgmV3
         mfpFqgUwy6pQqb791OUFc6a78LdioGhgdJjU8T2Gl4Dd3aIqzjuQc6jubDn0CyzB+xF9
         b8Yw==
X-Gm-Message-State: AOJu0Yx7SfaxVbxjutmbQTeQ6ugWTbW29nV+SDiuWI08DWblgxCjShDv
	hlMlnWXAvfEE10sbJ7mgr/a1vTMNHQ+/wVgwEncSi20CO6o=
X-Google-Smtp-Source: AGHT+IE930B2BHXU+DO/SJY+P+R7VxoHDA0HTMwEmJfeQP7KsGxrp9d/jgaFPmQ1HYxKQpy/rtsaLBzfJuTLY/sWt50=
X-Received: by 2002:a05:6870:b493:b0:1be:cee3:f3d with SMTP id
 y19-20020a056870b49300b001becee30f3dmr3319679oap.56.1694197451053; Fri, 08
 Sep 2023 11:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAcv5+6TL4qU9N-CsVDjusG=p-c4ZL3LYQQdCZyLDA4TkvJn3Q@mail.gmail.com>
 <dc3b5e51-1b6e-f6e6-958b-0a6fba17d4a4@gmail.com>
In-Reply-To: <dc3b5e51-1b6e-f6e6-958b-0a6fba17d4a4@gmail.com>
From: Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>
Date: Fri, 8 Sep 2023 19:23:58 +0100
Message-ID: <CAAcv5+6kbVo9gn2BeKLPD534afXyj4mDwG_0VrTiT+0wWv1C8w@mail.gmail.com>
Subject: Re: LET context deactivation
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I am using connman 1.37 with following main.conf:
root@raspberrypi0-wifi:~# cat /etc/connman/main.conf
[General]
NetworkInterfaceBlacklist=3Deth0,wlan0
DefaultAutoConnectTechnologies=3Dethernet,wifi

Please find below the logs:

root@raspberrypi0-wifi:~# ofonod[505]: oFono version 1.31
ofonod[505]: ../ofono-1.31/src/plugin.c:__ofono_plugin_init()
ofonod[505]: ../ofono-1.31/src/gprs-provision.c:ofono_gprs_provision_driver=
_register()
driver: 0x610540 name: GPRS context provisioning
ofonod[505]: ../ofono-1.31/plugins/push-notification.c:push_notification_in=
it()
ofonod[505]: ../ofono-1.31/plugins/smart-messaging.c:smart_messaging_init()
ofonod[505]: ../ofono-1.31/src/cdma-provision.c:ofono_cdma_provision_driver=
_register()
driver: 0x610514 name: CDMA provisioning
ofonod[505]: ../ofono-1.31/src/gprs-provision.c:ofono_gprs_provision_driver=
_register()
driver: 0x6104e8 name: Provisioning
ofonod[505]: ../ofono-1.31/plugins/upower.c:upower_init() upower init
ofonod[505]: ../ofono-1.31/src/handsfree-audio.c:ofono_handsfree_card_drive=
r_register()
driver: 0x610494
ofonod[505]: ../ofono-1.31/plugins/dun_gw_bluez5.c:dun_gw_init()
ofonod[505]: ../ofono-1.31/src/handsfree-audio.c:ofono_handsfree_card_drive=
r_register()
driver: 0x6103f8
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x61040c, name: hfp
ofonod[505]: ../ofono-1.31/plugins/xmm7xxx.c:xmm7xxx_init()
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x6103a0, name: xmm7xxx
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x610350, name: ublox
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x6102d8, name: quectel
ofonod[505]: ../ofono-1.31/plugins/telit.c:telit_init()
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x610288, name: telit
ofonod[505]: ../ofono-1.31/plugins/connman.c:connman_init()
ofonod[505]: ../ofono-1.31/src/private-network.c:ofono_private_network_driv=
er_register()
driver: 0x61025c, name: ConnMan Private Network
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x610214, name: sim7100
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x6101cc, name: sim900
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x610184, name: samsung
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x61013c, name: speedupcdma
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x6100ec, name: speedup
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x6100a4, name: alcatel
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x61004c, name: icera
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x610004, name: linktop
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60ffbc, name: nokiacdma
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60ff74, name: nokia
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60ff1c, name: gemalto
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fed4, name: cinterion
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fe4c, name: ste
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fdf4, name: ifx
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fdac, name: palmpre
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fd5c, name: novatel
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fd14, name: sierra
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fc9c, name: huawei
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fc54, name: zte
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fbf4, name: hso
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fba4, name: mbm
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fb54, name: calypso
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fb0c, name: wavecom
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fac4, name: g1
ofonod[505]: ../ofono-1.31/src/cdma-voicecall.c:ofono_cdma_voicecall_driver=
_register()
driver: 0x60b598, name: cdmamodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60b5b8, name: cdmamodem
ofonod[505]: ../ofono-1.31/src/cdma-connman.c:ofono_cdma_connman_driver_reg=
ister()
driver: 0x60b5d8, name: cdmamodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fa1c, name: phonesim
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60fa4c, name: localhfp
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60fa00, name: phonesim
ofonod[505]: ../ofono-1.31/src/ctm.c:ofono_ctm_driver_register()
driver: 0x60f9ec, name: phonesim
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60f9c4, name: phonesim
ofonod[505]: ../ofono-1.31/plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60b540, name: xmm7modem
ofonod[505]: ../ofono-1.31/src/ims.c:ofono_ims_driver_register()
driver: 0x60b568, name: xmm7modem
ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
driver: 0x60b580, name: xmm7modem
ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_reportin=
g_driver_register()
driver: 0x60b4d8, name: gemaltomodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60b4f0, name: gemaltomodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b494, name: ubloxmodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60e480, name: ubloxmodem
ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
driver: 0x60b4b0, name: ubloxmodem
ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
driver: 0x60b4c8, name: ubloxmodem
ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
driver: 0x60b418, name: speedupmodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60b33c, name: hfpmodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60b3c8, name: hfpmodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60b38c, name: hfpmodem
ofonod[505]: ../ofono-1.31/src/call-volume.c:ofono_call_volume_driver_regis=
ter()
driver: 0x60b3b0, name: hfpmodem
ofonod[505]: ../ofono-1.31/src/handsfree.c:ofono_handsfree_driver_register(=
)
driver: 0x60b3e8, name: hfpmodem
ofonod[505]: ../ofono-1.31/src/siri.c:ofono_siri_driver_register()
driver: 0x60b408, name: hfpmodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60b300, name: dunmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
driver: 0x60b324, name: dunmodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60b26c, name: stemodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b2e4, name: stemodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60b2bc, name: stemodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60b1a0, name: ifxmodem
ofonod[505]: ../ofono-1.31/src/audio-settings.c:ofono_audio_settings_driver=
_register()
driver: 0x60b1f0, name: ifxmodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60b1fc, name: ifxmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b224, name: ifxmodem
ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
driver: 0x60b240, name: ifxmodem
ofonod[505]: ../ofono-1.31/src/ctm.c:ofono_ctm_driver_register()
driver: 0x60b258, name: ifxmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b15c, name: hsomodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60b178, name: hsomodem
ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_reportin=
g_driver_register()
driver: 0x60b128, name: telitmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b140, name: telitncmmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b0dc, name: mbmmodem
ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
driver: 0x60b0f8, name: mbmmodem
ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_reportin=
g_driver_register()
driver: 0x60b110, name: mbmmodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60b074, name: calypsomodem
ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
driver: 0x60b0c4, name: calypsomodem
ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
driver: 0x60afb0, name: huaweimodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60afc4, name: huaweimodem
ofonod[505]: ../ofono-1.31/src/audio-settings.c:ofono_audio_settings_driver=
_register()
driver: 0x60b014, name: huaweimodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60b03c, name: huaweimodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60b020, name: huaweimodem
ofonod[505]: ../ofono-1.31/src/cdma-netreg.c:ofono_cdma_netreg_driver_regis=
ter()
driver: 0x60b064, name: huaweimodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60af6c, name: iceramodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60af88, name: iceramodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60af44, name: ztemodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60af28, name: swmodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60af00, name: nwmodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60adf8, name: atmodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60ae70, name: atmodem
ofonod[505]: ../ofono-1.31/src/call-barring.c:ofono_call_barring_driver_reg=
ister()
driver: 0x60ae48, name: atmodem
ofonod[505]: ../ofono-1.31/src/call-forwarding.c:ofono_call_forwarding_driv=
er_register()
driver: 0x60abec, name: atmodem
ofonod[505]: ../ofono-1.31/src/call-meter.c:ofono_call_meter_driver_registe=
r()
driver: 0x60ac0c, name: atmodem
ofonod[505]: ../ofono-1.31/src/call-settings.c:ofono_call_settings_driver_r=
egister()
driver: 0x60ab74, name: atmodem
ofonod[505]: ../ofono-1.31/src/phonebook.c:ofono_phonebook_driver_register(=
)
driver: 0x60ae60, name: atmodem
ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
driver: 0x60ade4, name: atmodem
ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
driver: 0x60abb8, name: atmodem
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60acfc, name: atmodem
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60ad64, name: atmodem-noef
ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
driver: 0x60adcc, name: atmodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60ac34, name: atmodem
ofonod[505]: ../ofono-1.31/src/cbs.c:ofono_cbs_driver_register()
driver: 0x60abd8, name: atmodem
ofonod[505]: ../ofono-1.31/src/call-volume.c:ofono_call_volume_driver_regis=
ter()
driver: 0x60ae90, name: atmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
driver: 0x60aea8, name: atmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60aec0, name: atmodem
ofonod[505]: ../ofono-1.31/src/gnss.c:ofono_gnss_driver_register()
driver: 0x60aedc, name: atmodem
ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
driver: 0x60aef0, name: atmodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f2f0, name: mbim
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60aa74, name: mbim
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60aa94, name: mbim
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60aafc, name: mbim
ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
driver: 0x60ab20, name: mbim
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
driver: 0x60ab40, name: mbim
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60ab58, name: mbim
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f288, name: gobi
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60a840, name: qmimodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60a8b0, name: qmimodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60a860, name: qmimodem
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60a8d4, name: qmimodem-legacy
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60a93c, name: qmimodem
ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
driver: 0x60a9a4, name: qmimodem
ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
driver: 0x60a9c4, name: qmimodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
driver: 0x60a9d8, name: qmimodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60a9f0, name: qmimodem
ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
driver: 0x60aa0c, name: qmimodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60aa1c, name: qmimodem
ofonod[505]: ../ofono-1.31/src/location-reporting.c:ofono_location_reportin=
g_driver_register()
driver: 0x60aa44, name: qmimodem
ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
driver: 0x60aa5c, name: qmimodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f220, name: u8500
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60f200, name: u8500
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f1b8, name: n900
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f170, name: isiusb
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60a324, name: isimodem
ofonod[505]: ../ofono-1.31/src/phonebook.c:ofono_phonebook_driver_register(=
)
driver: 0x60a314, name: isimodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60a344, name: isimodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60a368, name: isimodem
ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
driver: 0x60a3b8, name: isimodem
ofonod[505]: ../ofono-1.31/src/cbs.c:ofono_cbs_driver_register()
driver: 0x60a3d8, name: isimodem
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60a3ec, name: isimodem
ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
driver: 0x60a454, name: isimodem
ofonod[505]: ../ofono-1.31/src/call-forwarding.c:ofono_call_forwarding_driv=
er_register()
driver: 0x60a468, name: isimodem
ofonod[505]: ../ofono-1.31/src/call-settings.c:ofono_call_settings_driver_r=
egister()
driver: 0x60a488, name: isimodem
ofonod[505]: ../ofono-1.31/src/call-barring.c:ofono_call_barring_driver_reg=
ister()
driver: 0x60a4b8, name: isimodem
ofonod[505]: ../ofono-1.31/src/call-meter.c:ofono_call_meter_driver_registe=
r()
driver: 0x60a4d0, name: isimodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60a4f8, name: isimodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
driver: 0x60a520, name: isimodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60a538, name: isimodem
ofonod[505]: ../ofono-1.31/src/audio-settings.c:ofono_audio_settings_driver=
_register()
driver: 0x60a554, name: isimodem
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60a560, name: wgmodem2.5
ofonod[505]: ../ofono-1.31/drivers/rilmodem/rilmodem.c:rilmodem_init()
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_devinfo_driver_register()
driver: 0x60a04c, name: rilmodem
ofonod[505]: ../ofono-1.31/drivers/rilmodem/sim.c:ril_sim_init()
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_driver_register()
driver: 0x60a150, name: rilmodem
ofonod[505]: ../ofono-1.31/src/voicecall.c:ofono_voicecall_driver_register(=
)
driver: 0x60a090, name: rilmodem
ofonod[505]: ../ofono-1.31/src/sms.c:ofono_sms_driver_register()
driver: 0x60a1b8, name: rilmodem
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_driver_register()
driver: 0x60a06c, name: rilmodem
ofonod[505]: ../ofono-1.31/src/call-volume.c:ofono_call_volume_driver_regis=
ter()
driver: 0x60a0e0, name: rilmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_driver_register()
driver: 0x60a0f8, name: rilmodem
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x60a110, name: rilmodem
ofonod[505]: ../ofono-1.31/src/ussd.c:ofono_ussd_driver_register()
driver: 0x60a1d8, name: rilmodem
ofonod[505]: ../ofono-1.31/src/call-settings.c:ofono_call_settings_driver_r=
egister()
driver: 0x60a1ec, name: rilmodem
ofonod[505]: ../ofono-1.31/src/call-forwarding.c:ofono_call_forwarding_driv=
er_register()
driver: 0x60a21c, name: rilmodem
ofonod[505]: ../ofono-1.31/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x60a23c, name: rilmodem
ofonod[505]: ../ofono-1.31/src/call-barring.c:ofono_call_barring_driver_reg=
ister()
driver: 0x60a264, name: rilmodem
ofonod[505]: ../ofono-1.31/src/netmon.c:ofono_netmon_driver_register()
driver: 0x60a27c, name: rilmodem
ofonod[505]: ../ofono-1.31/src/stk.c:ofono_stk_driver_register()
driver: 0x60a294, name: rilmodem
ofonod[505]: ../ofono-1.31/src/cbs.c:ofono_cbs_driver_register()
driver: 0x60a2ac, name: rilmodem
ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_driver_register()
driver: 0x60a2c0, name: rilmodem
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f0e8, name: ril_intel
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f0a0, name: infineon
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_driver_register()
driver: 0x60f058, name: ril
ofonod[505]: ../ofono-1.31/plugins/udevng.c:udev_start()
ofonod[505]: ../ofono-1.31/plugins/udevng.c:enumerate_devices()
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() hub [1d6b:00=
02]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() usb [1d6b:00=
02]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() usb [1a40:01=
01]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.0/ttyUSB0/tty=
/ttyUSB0
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB0
(sim7x00) 255/255/255 [00] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.1/ttyUSB1/tty=
/ttyUSB1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB1
(sim7x00) 255/0/0 [01] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.2/ttyUSB2/tty=
/ttyUSB2
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB2
(sim7x00) 255/0/0 [02] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.3/ttyUSB3/tty=
/ttyUSB3
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB3
(sim7x00) 255/0/0 [03] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() option
[1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.4/ttyUSB4/tty=
/ttyUSB4
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/ttyUSB4
(sim7x00) 255/0/0 [04] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device()
qmi_wwan [1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device()
qmi_wwan [1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.5/net/wwan0
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() wwan0
(sim7x00) 255/255/255 [05] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device()
qmi_wwan [1e0e:9001]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1/1-1.1:1.5/usbmisc/cdc=
-wdm0
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_device() /dev/cdc-wdm0
(sim7x00) 255/255/255 [05] =3D=3D> (null) (null)
ofonod[505]: ../ofono-1.31/plugins/udevng.c:check_usb_device() hub [1a40:01=
01]
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono[  305.126450] Bluetooth: RFCOMM TTY layer initialized
-1.31/plugins/udevng.c:add_serial_device() Device is missing required
OFONO_DRIV[  305.138271] Bluetooth: RFCOMM socket layer initialized
ER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Dev[
305.151127] Bluetooth: RFCOMM ver 1.11
ice is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:add_serial_device() Device
is missing required OFONO_DRIVER property
ofonod[505]: ../ofono-1.31/plugins/udevng.c:create_modem()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:create_modem() driver=3Dsim7x00
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_create() name:
(null), type: sim7x00
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.1
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/dev/ttyUSB0 255/255/255 00 (null) (null) tty
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/dev/ttyUSB1 255/0/0 01 (null) (null) tty
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/dev/ttyUSB2 255/0/0 02 (null) (null) tty
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/dev/ttyUSB3 255/0/0 03 (null) (null) tty
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/dev/ttyUSB4 255/0/0 04 (null) (null) tty
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
/dev/cdc-wdm0 255/255/255 05 (null) (null) usbmisc
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00() wwan0
255/255/255 05 (null) (null) net
ofonod[505]: ../ofono-1.31/plugins/udevng.c:setup_sim7x00()
qmi=3D/dev/cdc-wdm0 net=3Dwwan0 mdm=3D/dev/ttyUSB2 gps=3D/dev/ttyUSB1
diag=3D/dev/ttyUSB0
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_set_driver() type: gobi
ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
0x19f5730 property Device
ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
0x19f5730 property Modem
ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
0x19f5730 property NetworkInterface
ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
0x19f5730 property GPS
ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
0x19f5730 property Diag
ofonod[505]: ../ofono-1.31/src/modem.c:set_modem_property() modem
0x19f5730 property SystemPath
ofonod[505]: ../ofono-1.31/src/modem.c:ofono_modem_register() 0x19f5730
ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_probe() 0x19f5730
ofonod[505]: ../ofono-1.31/src/modem.c:emit_modem_added() 0x19f5730
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property SystemPath
ofonod[505]: ../ofono-1.31/src/modem.c:call_modemwatches() 0x19f5730 added:=
1
ofonod[505]: ../ofono-1.31/plugins/dun_gw_bluez5.c:modem_watch()
modem: 0x19f5730, added: 1
ofonod[505]: ../ofono-1.31/plugins/hfp_ag_bluez5.c:modem_watch()
modem: 0x19f5730, added: 1
ofonod[505]: ../ofono-1.31/plugins/smart-messaging.c:modem_watch()
modem: 0x19f5730, added: 1
ofonod[505]: ../ofono-1.31/plugins/push-notification.c:modem_watch()
modem: 0x19f5730, added: 1
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property SystemPath
ofonod[505]: ../ofono-1.31/plugins/hfp_hf_bluez5.c:connect_handler()
Registering External Profile handler ...
ofonod[505]: ../ofono-1.31/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 0000111e-0000-1000-8000-00805f9b34fb (hfp_hf)
profile
ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_enable() 0x19f5730
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property Device
ofonod[505]: ../ofono-1.31/plugins/gobi.c:discover_cb()
ofonod[505]: ../ofono-1.31/plugins/bluez5.c:profile_register_cb()
ofonod[505]: ../ofono-1.31/plugins/gobi.c:create_dms_cb()
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb()
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() service capabilitie=
s 4
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() sim supported 2
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() radio =3D 4
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() radio =3D 5
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_caps_cb() radio =3D 8
ofonod[505]: ../ofono-1.31/plugins/gobi.c:get_oper_mode_cb()
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property AlwaysOnline
ofonod[505]: ../ofono-1.31/plugins/gobi.c:power_reset_cb()
ofonod[505]: ../ofono-1.31/src/modem.c:modem_change_state() old state:
0, new state: 1
ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_pre_sim() 0x19f5730
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_devinfo_probe()
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property ForceSimLegacy
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_sim_probe()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/voicecall.c:qmi_voicecall_probe=
()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:create_dms_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_caps()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:create_dms_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/voicecall.c:create_voice_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:get_caps_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_manufacture=
r()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:create_uim_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:string_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_model()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:event_registration_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:event_registration_cb()
event mask 0x0003
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:string_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_revision()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_card_status_cb()
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb0
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb0
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb0
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb0
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_state_watch() 0x19f4fb0
ofonod[505]: Interface org.ofono.AllowedAccessPoints not found on the
interface_list
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:string_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:qmi_query_serial()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: Requested file structure differs from SIM: 6fb7
ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g2_read_cb() 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/devinfo.c:get_ids_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6fb7 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/voicecall.c:ecc_g3_read_cb() 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x2fe2 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x2fe2 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
bufoff: 0, dataoff: 0, tocopy: 10
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f05 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x6f05 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
bufoff: 0, dataoff: 0, tocopy: 20
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x2f05 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x2f05 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
bufoff: 0, dataoff: 0, tocopy: 16
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_query_passwd_state()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:query_passwd_state_cb()
passwd state 0
ofonod[505]: ../ofono-1.31/src/sim.c:sim_pin_query_cb() sim->pin_type:
0, pin_type: 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_query_pin_retries()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6fae path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6fad path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:query_pin_retries_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x6fad path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
bufoff: 0, dataoff: 0, tocopy: 4
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f16 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f38 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x6f38 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
bufoff: 0, dataoff: 0, tocopy: 13
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f56 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x6f56 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block_cb()
bufoff: 0, dataoff: 0, tocopy: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_imsi()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_imsi_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_transparent()
file id 0x6f07 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag)
profile
ofonod[505]: ../ofono-1.31/src/modem.c:modem_change_state() old state:
1, new state: 2
ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_post_sim() 0x19f5730
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:qmimodem_lte_probe()
qmimodem lte probe
ofonod[505]: ../ofono-1.31/src/lte.c:ofono_lte_create() LTE atom created
ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:qmi_radio_sett=
ings_probe()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:qmi_sms_probe()
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property ForceSimLegacy
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property AlwaysOnline
ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:create_dms_cb(=
)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6fca path len 0
ofonod[505]: ../ofono-1.31/plugins/bluez5.c:profile_register_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:create_wds_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:create_nas_cb(=
)
ofonod[505]: ../ofono-1.31/src/radio-settings.c:radio_load_settings()
TechnologyPreference: 0
ofonod[505]: ../ofono-1.31/src/radio-settings.c:radio_load_settings() GsmBa=
nd: 0
ofonod[505]: ../ofono-1.31/src/radio-settings.c:radio_load_settings()
UmtsBand: 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:qmi_set_rat_mo=
de()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:create_wms_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: Unable to read waiting messages numbers from SIM
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6fc9 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:get_default_profile_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:get_default_profile_cb()
Default profile index: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/radio-settings.c:set_system_sel=
ection_pref_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:set_event_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: Unable to read mailbox identifies from SIM
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f11 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:reset_profile_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:qmimodem_lte_set_default_=
attach_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() found 6 r=
outes
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
0 class 0 =3D> type 1 value 3
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
0 class 1 =3D> type 1 value 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
0 class 2 =3D> type 0 value 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
0 class 3 =3D> type 1 value 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
0 class 4 =3D> type 1 value 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb() type
0 class 5 =3D> type 1 value 3
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_routes_cb()
transfer status report 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/src/message-waiting.c:mw_cphs_mwis_read_cb()
No CPHS MWIS on SIM
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f40 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/lte.c:modify_profile_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:set_routes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:qmi_bearer_set() bearer 3
ofonod[505]: ../ofono-1.31/src/sms.c:sms_restore_tx_queue()
ofonod[505]: ../ofono-1.31/plugins/push-notification.c:sms_watch() register=
ed
ofonod[505]: ../ofono-1.31/plugins/smart-messaging.c:sms_watch() registered
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
msg tag 0 mode 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
msg tag 2 mode 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
msg tag 0 mode 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:delete_msg() delete
msg tag 2 mode 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_protocol()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6f40 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:set_domain_pref_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_protocol_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_protocol_cb()
device supports CDMA and WCDMA msg protocol
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_record()
file id 0x6f40 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb()
Err: get msg list mode=3D0 47=3DUNKNOWN
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:read_generic_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x4f20 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sms.c:get_msg_list_cb() msgs fo=
und 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()

root@raspberrypi0-wifi:~# dbus-send --system --type=3Dmethod_call
--print-reply --dest=3Dorg.ofono /sim7x00_0 org.ofono.Modem.SetProperty
string:"Online" variant:boolean:true
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property AlwaysOnline
ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_set_online() 0x19f5730 onlin=
e
ofonod[505]: ../ofono-1.31/plugins/gobi.c:set_online_cb()
method return time=3D1600598956.298364 sender=3D:1.9 -> destination=3D:1.11
serial=3D55 reply_serial=3D2
ofonod[505]: ../ofono-1.31/src/modem.c:modem_change_state() old state:
2, new state: 3
ofonod[505]: ../ofono-1.31/plugins/gobi.c:gobi_post_online() 0x19f5730
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_netr=
eg_probe()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/netmon.c:qmi_netmon_probe()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/ussd.c:qmi_ussd_probe()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:qmi_gprs_probe()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_gprs_context=
_probe()
root@raspberrypi0-wifi:~# ofonod[505]:
../ofono-1.31/drivers/qmimodem/network-registration.c:create_nas_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/netmon.c:create_nas_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/ussd.c:create_voice_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:create_nas_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:create_wds_cb()
ofonod[505]: ../ofono-1.31/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw)
profile
ofonod[505]: ../ofono-1.31/plugins/bluez5.c:profile_register_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:create_wda_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:set_even=
t_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_regi=
stration_status()
ofonod[505]: ../ofono-1.31/src/sim.c:ofono_sim_add_spn_watch() 0x19f4fb0
ofonod[505]: ../ofono-1.31/src/network.c:__ofono_netreg_add_status_watch()
0x1a11918
ofonod[505]: ../ofono-1.31/src/network.c:__ofono_netreg_add_status_watch()
0x1a11918
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 0
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status unregistered (0)
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_detached_notify() /sim7x00=
_0
ofonod[505]: ../ofono-1.31/src/simfs.c:sim_fs_op_read_block() bufoff:
0, seekoff: 39, toread: 17
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_data_format_=
cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_data_format_=
cb()
expected data set to raw-ip
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:create_wds_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_ss_i=
nfo_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 2
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 2 lac -1 cellid -1 tech -1
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 2 tech -1 lac -1 ci -1
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, (nil)
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 2 (searching)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:qmi_read_attributes()
file id 0x6f15 path len 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/sim.c:get_file_attributes_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status unregistered (0)
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_detached_notify() /sim7x00=
_0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_info_=
notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 2
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
60502 (605:02)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 2 lac -1 cellid -1 tech 7
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 2 tech 7 lac -1 ci -1
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, (nil)
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 2 (searching)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
rat 8 band 145 channel 6200
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
signal with 40%(-80 dBm) on 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params()
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status registered (1)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_info_=
notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
60502 (605:02)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 0 lac 65534 cellid 11038465 tech 7
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 1 tech 7 lac 65534 ci 11038465
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_curr=
ent_operator()
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, (nil)
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (registered=
)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_sign=
al_strength()
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (registered=
)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
rat 8 band 145 channel 6200
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb()
Default profile index: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params()
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status registered (1)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_info_=
notify()
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_time_notify()
net time 2023-09-08 18:05:31 utcoff 3600 dst 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 2 lac -1 cellid -1 tech 7
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 1 tech 7 lac 65534 ci 11038465
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_curr=
ent_operator()
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, 0x19fb200
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_sign=
al_strength()
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (registered=
)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
signal with -80 dBm on 8
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_strength_notify()
strength 40
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_param_cb(=
)
ofonod[505]: LTE attach IP type: 0
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_cid_activated() cid 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_gprs_read_se=
ttings()
cid 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
signal with -80 dBm on 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
packet handle -2031133168
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
conn status 2
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
ip family 4
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
PDP type 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
IP addr: 102.27.72.156
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Gateway: 102.27.72.157
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Gateway netmask: 255.255.255.248
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Primary DNS: 196.203.82.66
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Secondary DNS: 8.8.4.4
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property NetworkInterface
ofonod[505]: ../ofono-1.31/src/gprs.c:pri_read_settings_callback() 0x1a0dc0=
8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params()
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status registered (1)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_info_=
notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 2 lac -1 cellid 11038468 tech 7
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 1 tech 7 lac 65534 ci 11038468
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_curr=
ent_operator()
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, 0x19fb200
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_sign=
al_strength()
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (registered=
)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
rat 8 band 145 channel 1350
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
signal with -80 dBm on 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
signal with 20%(-86 dBm) on 8
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_strength_notify()
strength 20
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status unregistered (0)
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_detached_notify() /sim7x00=
_0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_info_=
notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 2 lac -1 cellid -1 tech 7
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 1 tech 7 lac 65534 ci 11038468
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_curr=
ent_operator()
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, 0x19fb200
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_sign=
al_strength()
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (registered=
)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:ss_info_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:handle_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:extract_ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_params()
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_status_notify()
/sim7x00_0 status registered (1)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:ss_info_=
notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
serving system status 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
radio in use 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:extract_=
ss_info()
roaming 2 lac -1 cellid -1 tech 7
ofonod[505]: ../ofono-1.31/src/network.c:ofono_netreg_status_notify()
/sim7x00_0 status 1 tech 7 lac 65534 ci 11038468
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_curr=
ent_operator()
ofonod[505]: ../ofono-1.31/src/network.c:current_operator_callback()
0x1a11918, 0x19fb200
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:qmi_sign=
al_strength()
ofonod[505]: ../ofono-1.31/src/gprs.c:netreg_status_changed() 1 (registered=
)
ofonod[505]: ../ofono-1.31/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:event_no=
tify()
rat 8 band 122 channel 1350
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
signal with -86 dBm on 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_default_profile_cb()
Default profile index: 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/network-registration.c:get_rssi=
_cb()
signal with -86 dBm on 8
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs.c:get_lte_attach_param_cb(=
)
ofonod[505]: LTE attach IP type: 0
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_cid_activated() cid 1
ofonod[505]: ../ofono-1.31/src/gprs.c:ofono_gprs_cid_activated() cid 1
already activated

root@raspberrypi0-wifi:~# dbus-send --system --print-reply
--dest=3Dorg.ofono /sim7x00_0 org.ofono.ConnectionManager.GetContexts
method return time=3D1600598975.327997 sender=3D:1.9 -> destination=3D:1.12
serial=3D82 reply_serial=3D2
   array [
      struct {
         object path "/sim7x00_0/context1"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean true
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string "internet.tn"
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "AuthenticationMethod"
               variant                   string "chap"
            )
            dict entry(
               string "Settings"
               variant                   array [
                     dict entry(
                        string "Interface"
                        variant                            string "wwan0"
                     )
                     dict entry(
                        string "Method"
                        variant                            string "static"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"102.27.72.156"
                     )
                     dict entry(
                        string "Netmask"
                        variant                            string
"255.255.255.248"
                     )
                     dict entry(
                        string "Gateway"
                        variant                            string
"102.27.72.157"
                     )
                     dict entry(
                        string "DomainNameServers"
                        variant                            array [
                              string "196.203.82.66"
                              string "8.8.4.4"
                           ]
                     )
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
   ]
root@raspberrypi0-wifi:~# dbus-send --system --type=3Dmethod_call
--print-reply --dest=3Dorg.ofono /sim7x00_0/context1
org.ofono.ConnectionContext.SetProperty string:"Active"
variant:boolean:false
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_deactivate_p=
rimary()
cid 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:stop_net_cb()
method return time=3D1600598979.752358 sender=3D:1.9 -> destination=3D:1.13
serial=3D83 reply_serial=3D2
root@raspberrypi0-wifi:~# ofonod[505]:
../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notify()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
conn status 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
ip family 4
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:qmi_activate_pri=
mary()
cid 1
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:start_net_cb()
packet handle -2031133168
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
conn status 2
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:pkt_status_notif=
y()
ip family 4
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
PDP type 0
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
IP addr: 102.27.72.156
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Gateway: 102.27.72.157
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Gateway netmask: 255.255.255.248
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Primary DNS: 196.203.82.66
ofonod[505]: ../ofono-1.31/drivers/qmimodem/gprs-context.c:get_settings_cb(=
)
Secondary DNS: 8.8.4.4
ofonod[505]: ../ofono-1.31/src/modem.c:get_modem_property() modem
0x19f5730 property NetworkInterface
ofonod[505]: ../ofono-1.31/src/gprs.c:pri_activate_callback() 0x1a0dc08

root@raspberrypi0-wifi:~# dbus-send --system --print-reply
--dest=3Dorg.ofono /sim7x00_0 org.ofono.ConnectionManager.GetContexts
method return time=3D1600598993.138198 sender=3D:1.9 -> destination=3D:1.14
serial=3D89 reply_serial=3D2
   array [
      struct {
         object path "/sim7x00_0/context1"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean true
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string "internet.tn"
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "AuthenticationMethod"
               variant                   string "chap"
            )
            dict entry(
               string "Settings"
               variant                   array [
                     dict entry(
                        string "Interface"
                        variant                            string "wwan0"
                     )
                     dict entry(
                        string "Method"
                        variant                            string "static"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"102.27.72.156"
                     )
                     dict entry(
                        string "Netmask"
                        variant                            string
"255.255.255.248"
                     )
                     dict entry(
                        string "Gateway"
                        variant                            string
"102.27.72.157"
                     )
                     dict entry(
                        string "DomainNameServers"
                        variant                            array [
                              string "196.203.82.66"
                              string "8.8.4.4"
                           ]
                     )
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
   ]

Bestregards,
Mohamed Ali

Le ven. 8 sept. 2023 =C3=A0 03:24, Denis Kenzior <denkenz@gmail.com> a =C3=
=A9crit :
>
> Hi Mohamed,
>
> On 9/7/23 11:49, Mohamed Ali Fodha wrote:
> > Hello,
> >
> > I am using SIM7600 chip with ofono 1.31, when I set Online to true,
> > the internet context is activated and it is not possible to deactivate
> > it at all using the following command:
>
> Note that on LTE the default bearer is activated when registering to the
> network.  One context always exists while registered to LTE.
>
> >
> > dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofon=
o
> > /csim7x00_0/context1 org.ofono.ConnectionContext.SetProperty
> > string:"Active" variant:boolean:false
> >
> > According to the log I saw always activate_primary which is
> > automatically called after above command.
>
> Are you running connman or something else along side oFono? Sounds like
> something is setting the context back up.
>
> >
> > Any idea how to disable the automatic LTE context which is created?
> >
>
> Hard to answer this without more context / info / logs.
>
> Regards,
> -Denis
>
