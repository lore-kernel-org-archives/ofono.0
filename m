Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24B181
	for <ofono@lists.linux.dev>; Sat, 27 Apr 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239111; cv=none; b=nwKUM6brJZkTjBthmHHm31koprvzZIwtjfAFX0iwyPEXhhP6U/THw36TsbaqVVC5Ep75Vzemh5CPtAb6byYPi5Z2kNSQ9j9UEPBBST9JppCSd9hz7+s1UUGnGQPT/NPQllC+Q9FxGG34iLNQaJfyATuXAOy74387RdkA1Bco+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239111; c=relaxed/simple;
	bh=CtRhFbUdm4HwoTV943XG3IL9hwPCI4RjKTiZhsu0loc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkKvozD+jwi7bJaBZoP1xR2w21AXNV9R+3MpJhfB+gj3doXRv2KLRX0XzdJD6tWylwq07veKU0M2xn2XhmZmmpe5XNagRcMZehjdWynvxJO2KxUVIPiRl+NKa+kRUClIwi92IFieb6HHsenCqgbgEt4tZ2mJw436enePu+Lpdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWvWblhi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWvWblhi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so9307585e9.3
        for <ofono@lists.linux.dev>; Sat, 27 Apr 2024 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714239105; x=1714843905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4P834zxQQq3iuK1PYqisfRCIyV5K18xp0fgt6ujTN8=;
        b=IWvWblhiGIwWs8Ss6W8gKmt99/oaV/tAd26X1/RMKxpqqgWF5OwsN4cmQ6yJ0TWsyA
         N+B/iSdqgNBSNMR3Ut5LUuW2r/9AqqdkJyrYTCNjVI6JE1FGC8fq137nXHn8vT8x8T3N
         98AfTjAh7DrFbPcI/u93qJTBv9BxH5Gt9QVoHyE42pW7/dO1LwbIszr/QAoLurhpoB0e
         tFv4LU69LZ5GACgCD3iiMLwiagqIXBpKoGkkTwfKqHJYpNM4P0/73KbwQJJutrXYcUIT
         ssTpNQzD9C7t9c0rV7lea2JwSJSHAUYZAXuuINioFSZF1EOQwZz4psvESf5SoCIntDKv
         jSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714239105; x=1714843905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4P834zxQQq3iuK1PYqisfRCIyV5K18xp0fgt6ujTN8=;
        b=CbAWFCWrOPQLsf2wYAb/DgUua9Vls+5GGMHux9BObEpUyLXtk+/d/+lyAjRXxHKlqn
         91yVefZKFknbpr1Q1oo3/OJlHtX/Fks0e1BkAzmpw7tyC2asPePQ1hypONxBTBkQjj9d
         QleT8A8ln9zy1ow/BQ3U3ZTQgxbZemc0eqmsAT3ZT0Fsy/iSc4j7kJs7Coh62ed5fScu
         f4Wv9s3V0qLuhJwD1RdoouKCAZrf23YR9v75tI6iUZP2C8c6fOCVCSSXa/ZnS3g6Vaws
         Cd+hyYlfQSuCqbvK2bkgdHLaI7az0NGezhDmp6o7Kjtulz8t7rYW7ytX6GxqQl5Ox5BC
         aYeQ==
X-Gm-Message-State: AOJu0YyNinU2XlIpHpnVhDLS+Pj94WVW3cBAslFTWP/N1NvM2oqUbNTT
	LNiI8BY2qA0eaWqXNewsWMjFBkPJ4PfEIYLBKMqPBdMlEb0oaf1G312+YA==
X-Google-Smtp-Source: AGHT+IEfoQWoHDcnb3QSowspcxf1Vb+/xocsVMk+czpraEeAvZffjI52vvgIIswnuZDSo7+YH5ldUQ==
X-Received: by 2002:a05:600c:314d:b0:41b:f116:8c22 with SMTP id h13-20020a05600c314d00b0041bf1168c22mr879068wmo.14.1714239103730;
        Sat, 27 Apr 2024 10:31:43 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0041befc2652csm1741093wmo.31.2024.04.27.10.31.42
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 10:31:43 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: adam@piggz.co.uk
To: ofono@lists.linux.dev
Subject: Re: [PATCH v6] qmimodem: voicecall: Implement DTMF tones
Date: Sat, 27 Apr 2024 18:31:42 +0100
Message-ID: <9691207.eNJFYEL58v@adam-laptop-hp>
In-Reply-To: <5571717.rdbgypaU67@adam-laptop-hp>
References:
 <20240426212235.2627-1-adam@piggz.co.uk> <5571717.rdbgypaU67@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I thought I would include the valgrind output while removing the modem mid-
call after sending some dtmf digits.

The leak which is identified at the end is in a patch im not upstreaming, which 
is part of the making the gobi driver work with the other patches im using to 
support sailfish.  The other thing of note is some logs relating to the SIM 
code.


[root@PinePhonePro defaultuser]# valgrind --leak-check=full ./ofonod -dn
==1888== Memcheck, a memory error detector
==1888== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==1888== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==1888== Command: ./ofonod -dn
==1888== 
ofonod[1888]: oFono version 2.5
src/main.c:main() Using configuration directory: /etc/ofono
ofonod[1888]: src/module.c:__ofono_modules_init() 
ofonod[1888]: src/manager.c:manager_init() manager_init
ofonod[1888]: src/provision.c:provision_init() 
ofonod[1888]: src/slot-manager.c:ofono_slot_manager_object_init() Default 
voice sim is (auto)
ofonod[1888]: src/slot-manager.c:ofono_slot_manager_object_init() Default data 
sim is (auto)
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_set_block() blocking 
ALL requests
ofonod[1888]: src/plugin.c:__ofono_plugin_init() 
ofonod[1888]: Can't load /usr/lib64/ofono/plugins/amlplugin.so: /usr/lib64/
ofono/plugins/amlplugin.so: undefined symbol: 
ofono_voicecall_is_emergency_number
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_plugin_init() 
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_config() loading 
configuration from /etc/ofono/push_forwarder.d
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_config() reading 
org.nemomobile.MmsEngine.conf
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler() registered 
MMS Engine
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   
ContentType: application/vnd.wap.mms-message
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Interface: 
org.nemomobile.MmsEngine
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Service: 
org.nemomobile.MmsEngine
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Method: 
push
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Path: /
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_config() reading ofono-
provisioning.conf
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler() registered 
Jolla Provisioning Handler
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   
ContentType: application/vnd.wap.connectivity-wbxml
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Interface: 
org.nemomobile.provisioning.interface
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Service: 
org.nemomobile.provisioning
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Method: 
HandleProvisioningMessage
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_parse_handler()   Path: /
ofonod[1888]: plugins/push-notification.c:push_notification_init() 
ofonod[1888]: plugins/smart-messaging.c:smart_messaging_init() 
ofonod[1888]: plugins/upower.c:upower_init() upower init
ofonod[1888]: plugins/hfp_ag_bluez5.c:hfp_ag_init() 
ofonod[1888]: src/handsfree-audio.c:ofono_handsfree_card_driver_register() 
driver: 0x5838b0
ofonod[1888]: plugins/dun_gw_bluez5.c:dun_gw_init() 
ofonod[1888]: src/handsfree-audio.c:ofono_handsfree_card_driver_register() 
driver: 0x583780
ofonod[1888]: plugins/connman.c:connman_init() 
ofonod[1888]: src/private-network.c:ofono_private_network_driver_register() 
driver: 0x583728, name: ConnMan Private Network
ofonod[1888]: plugins/phonesim.c:parse_config() filename /etc/ofono/
phonesim.conf
ofonod[1888]: Reading of /etc/ofono/phonesim.conf failed: No such file or 
directory
ofonod[1888]: plugins/sailfish_access.c:sailfish_access_init() 
ofonod[1888]: src/dbus-access.c:ofono_dbus_access_plugin_register() Sailfish D-
Bus access
ofonod[1888]: plugins/udevng.c:udev_start() 
ofonod[1888]: plugins/udevng.c:enumerate_devices() 
ofonod[1888]: plugins/udevng.c:check_usb_device() hub [1d6b:0002]
ofonod[1888]: plugins/udevng.c:check_usb_device() hub [1d6b:0001]
ofonod[1888]: plugins/udevng.c:check_usb_device() hub [1d6b:0002]
ofonod[1888]: plugins/udevng.c:check_usb_device() usb [1d6b:0002]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() option [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() qmi_wwan [2c7c:0125]
ofonod[1888]: plugins/udevng.c:check_usb_device() qmi_wwan [2c7c:0125]
ofonod[1888]: plugins/udevng.c:add_device() modem:/sys/devices/platform/
fe3c0000.usb/usb1/1-1 device:/sys/devices/platform/fe3c0000.usb/
usb1/1-1/1-1:1.4/net/wwan0
ofonod[1888]: plugins/udevng.c:add_device() wwan0 (quectelqmi) 255/255/255 
[04] ==> (null) (null)
ofonod[1888]: plugins/udevng.c:check_usb_device() qmi_wwan [2c7c:0125]
ofonod[1888]: plugins/udevng.c:add_device() modem:/sys/devices/platform/
fe3c0000.usb/usb1/1-1 device:/sys/devices/platform/fe3c0000.usb/
usb1/1-1/1-1:1.4/usbmisc/cdc-wdm0
ofonod[1888]: plugins/udevng.c:add_device() /dev/cdc-wdm0 (quectelqmi) 
255/255/255 [04] ==> (null) (null)
ofonod[1888]: plugins/udevng.c:check_usb_device() hub [1d6b:0001]
ofonod[1888]: plugins/udevng.c:create_modem() /sys/devices/platform/
fe3c0000.usb/usb1/1-1
ofonod[1888]: plugins/udevng.c:create_modem() driver=quectelqmi
ofonod[1888]: src/modem.c:ofono_modem_create() name: (null), type: quectelqmi
ofonod[1888]: plugins/udevng.c:setup_quectelqmi() /sys/devices/platform/
fe3c0000.usb/usb1/1-1
ofonod[1888]: plugins/udevng.c:setup_quectelqmi() /dev/cdc-wdm0 255/255/255 04 
(null) usbmisc
ofonod[1888]: plugins/udevng.c:setup_quectelqmi() wwan0 255/255/255 04 (null) 
net
ofonod[1888]: plugins/udevng.c:setup_quectelqmi() gps=(null) aux=(null)
ofonod[1888]: plugins/udevng.c:setup_qmi() qmi: /dev/cdc-wdm0 net: wwan0 
kernel_driver: qmi_wwan interface_number: 04
ofonod[1888]: src/modem.c:ofono_modem_set_driver() type: gobi
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property Device
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property 
KernelDriver
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property 
NetworkInterface
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property 
InterfaceNumber
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property 
NetworkInterfaceIndex
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property Bus
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:ofono_modem_register() 0x5d50280
ofonod[1888]: plugins/gobi.c:gobi_probe() 0x5d50280
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
KernelDriver
ofonod[1888]: plugins/gobi.c:gobi_probe() kernel_driver: qmi_wwan
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
NetworkInterfaceIndex
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
NetworkInterface
ofonod[1888]: plugins/gobi.c:gobi_probe() net: wwan0 (6)
ofonod[1888]: src/modem.c:ofono_modem_set_capabilities() 1
ofonod[1888]: gobi_slot_plugin_start
ofonod[1888]: src/modem.c:emit_modem_added() 0x5d50280
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:call_modemwatches() 0x5d50280 added:1
ofonod[1888]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x5d50280, added: 1
ofonod[1888]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x5d50280, added: 1
ofonod[1888]: plugins/hfp_ag_bluez5.c:modem_watch() Adding modem 0x5d50280, 
info: 0x5d8fc60
ofonod[1888]: plugins/sailfish_bt.c:modem_watch() modem: 0x5d50280, added: 1
ofonod[1888]: plugins/smart-messaging.c:modem_watch() modem: 0x5d50280, added: 
1
ofonod[1888]: plugins/push-notification.c:modem_watch() modem: 0x5d50280, 
added: 1
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_modem_watch() modem: 
0x5d50280, added: 1
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/handsfree-audio.c:am_agent_register() Agent :1.51 registered 
with the CODECs: CVSD
ofonod[1888]: src/handsfree-audio.c:am_agent_register() Wideband speech 
disabled: no mSBC support
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking MODEM request GetAll 0x5db8160
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: plugins/hfp_hf_bluez5.c:connect_handler() Registering External 
Profile handler ...
ofonod[1888]: plugins/bluez5.c:bt_register_profile() Bluetooth: Registering 
0000111e-0000-1000-8000-00805f9b34fb (hfp_hf) profile
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5ddd540
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5ddf9a0
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5de4730
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5de6b90
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5de8ff0
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5df2710
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5df71b0
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5df9610
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5dfba70
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5dfded0
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5dfe2f0
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5dfe710
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_reply_or_block() 
blocking IMEI request GetAll8 0x5e07290
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: plugins/bluez5.c:profile_register_cb() 
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
DevicePath
ofonod[1888]: src/modem.c:ofono_modem_create() name: hfp/org/bluez/hci0/
dev_14_13_33_81_6B_CC, type: hfp
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5e2a410 property Remote
ofonod[1888]: src/modem.c:set_modem_property() modem 0x5e2a410 property 
DevicePath
ofonod[1888]: src/modem.c:ofono_modem_register() 0x5e2a410
ofonod[1888]: plugins/hfp_hf_bluez5.c:hfp_probe() modem: 0x5e2a410
ofonod[1888]: src/modem.c:emit_modem_added() 0x5e2a410
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:call_modemwatches() 0x5e2a410 added:1
ofonod[1888]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x5e2a410, added: 1
ofonod[1888]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x5e2a410, added: 1
ofonod[1888]: plugins/hfp_ag_bluez5.c:modem_watch() Adding modem 0x5e2a410, 
info: 0x5e40b80
ofonod[1888]: plugins/sailfish_bt.c:modem_watch() modem: 0x5e2a410, added: 1
ofonod[1888]: plugins/smart-messaging.c:modem_watch() modem: 0x5e2a410, added: 
1
ofonod[1888]: plugins/push-notification.c:modem_watch() modem: 0x5e2a410, 
added: 1
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_modem_watch() modem: 
0x5e2a410, added: 1
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
DevicePath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
DevicePath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: plugins/gobi.c:gobi_enable() 0x5d50280
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
KernelDriver
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property Device
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: plugins/hfp_hf_bluez5.c:hfp_enable() 0x5e2a410
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
DevicePath
ofonod[1888]: plugins/bluez5.c:device_send_message() Bluetooth: sending 
ConnectProfile for 0000111f-0000-1000-8000-00805f9b34fb on /org/bluez/hci0/
dev_14_13_33_81_6B_CC
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: ConnectProfile() replied an error: org.bluez.Error.NotReady, br-
connection-adapter-not-powered
ofonod[1888]: src/slot-manager.c:slot_manager_init_countdown_cb() done with 
registrations
ofonod[1888]: plugins/gobi.c:gobi_slot_driver_init() gobi_slot_driver_init
ofonod[1888]: plugins/gobi.c:gobi_slot_driver_start() gobi_slot_driver_start
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: plugins/gobi.c:discover_cb() 
ofonod[1888]: plugins/gobi.c:create_dms_cb() 
ofonod[1888]: plugins/gobi.c:create_wda_cb() 
ofonod[1888]: plugins/gobi.c:get_data_format_cb() 
ofonod[1888]: Got IMEI 867698048642485
ofonod[1888]: plugins/gobi.c:gobi_slot_driver_startup_check() 
gobi_slot_driver_startup_check
ofonod[1888]: src/sailfish_watch.c:ofono_watch_new() quectelqmi_0 created
ofonod[1888]: src/sim-info-dbus.c:sim_info_dbus_new() /quectelqmi_0
ofonod[1888]: src/cell-info-control.c:cell_info_control_get() /quectelqmi_0 
created
ofonod[1888]: src/slot-manager.c:slot_add_internal() quectelqmi_0
ofonod[1888]: plugins/gobi.c:get_caps_cb() 
ofonod[1888]: plugins/gobi.c:get_caps_cb() service capabilities 4
ofonod[1888]: plugins/gobi.c:get_caps_cb() sim supported 2
ofonod[1888]: plugins/gobi.c:get_caps_cb() radio = 4
ofonod[1888]: plugins/gobi.c:get_caps_cb() radio = 5
ofonod[1888]: plugins/gobi.c:get_caps_cb() radio = 8
ofonod[1888]: plugins/gobi.c:get_oper_mode_cb() 
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
AlwaysOnline
ofonod[1888]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[1888]: plugins/gobi.c:gobi_pre_sim() 0x5d50280
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_devinfo_probe() 
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
ForceSimLegacy
ofonod[1888]: drivers/qmimodem/sim.c:qmi_sim_probe() 
ofonod[1888]: drivers/qmimodem/voicecall.c:qmi_voicecall_probe() 
ofonod[1888]: plugins/gobi.c:gobi_slot_set_sim_state() gobi_slot_set_sim_state
ofonod[1888]: src/slot-manager.c:slot_manager_update_ready() ready
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_set_block() unblocking 
ALL requests
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_signal_boolean() 
ReadyChanged 1
ofonod[1888]: drivers/qmimodem/devinfo.c:create_dms_cb() 
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_query_caps() 
ofonod[1888]: drivers/qmimodem/sim.c:create_dms_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:create_voice_cb() 
ofonod[1888]: plugins/hfp_ag_bluez5.c:voicecall_watch() 
ofonod[1888]: drivers/qmimodem/devinfo.c:get_caps_cb() 
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_query_manufacturer() 
ofonod[1888]: drivers/qmimodem/sim.c:create_uim_cb() 
ofonod[1888]: drivers/qmimodem/devinfo.c:string_cb() 
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_query_model() 
ofonod[1888]: drivers/qmimodem/sim.c:event_registration_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:event_registration_cb() event mask 0x0003
ofonod[1888]: drivers/qmimodem/devinfo.c:string_cb() 
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_query_revision() 
ofonod[1888]: drivers/qmimodem/sim.c:get_card_status_cb() 
ofonod[1888]: src/sim.c:ofono_sim_add_state_watch() 0x5eeec00
ofonod[1888]: src/sim.c:ofono_sim_add_state_watch() 0x5eeec00
ofonod[1888]: src/sailfish_watch.c:ofono_watch_sim_notify() quectelqmi_0 sim 
registered
ofonod[1888]: src/sim.c:ofono_sim_add_state_watch() 0x5eeec00
ofonod[1888]: src/sim.c:ofono_sim_add_iccid_watch() 0x5eeec00
ofonod[1888]: src/sim.c:ofono_sim_add_imsi_watch() 0x5eeec00
ofonod[1888]: src/sim.c:ofono_sim_add_state_watch() 0x5eeec00
ofonod[1888]: src/sim.c:ofono_sim_add_state_watch() 0x5eeec00
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_sim_watch() registered
ofonod[1888]: plugins/hfp_ag_bluez5.c:sim_watch() 
ofonod[1888]: src/sim.c:ofono_sim_add_state_watch() 0x5eeec00
ofonod[1888]: drivers/qmimodem/devinfo.c:string_cb() 
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_query_serial() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fb7 path 
len 0
ofonod[1888]: drivers/qmimodem/devinfo.c:get_ids_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: Requested file structure differs from SIM: 6fb7
ofonod[1888]: src/voicecall.c:ecc_g2_read_cb() 0
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fb7 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/voicecall.c:ecc_g3_read_cb() 1
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/voicecall.c:ecc_g3_read_cb() 1
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/voicecall.c:ecc_g3_read_cb() 1
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/voicecall.c:ecc_g3_read_cb() 1
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/voicecall.c:ecc_g3_read_cb() 1
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x2fe2 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x2fe2 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, 
tocopy: 10
ofonod[1888]: src/sim-info.c:sim_info_iccid_watch_cb() quectelqmi_0 
8944200122784036312
ofonod[1888]: src/sim-info.c:sim_info_load_cache() quectelqmi_0 
imsi[8944200122784036312] = 234206313731703
ofonod[1888]: src/sim-info.c:sim_info_load_cache() quectelqmi_0 no spn for 
imsi 234206313731703
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f05 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x6f05 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, 
tocopy: 10
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x2f05 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x2f05 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, 
tocopy: 10
==1888== Invalid read of size 1
==1888==    at 0x486EA2C: strlen (vg_replace_strmem.c:494)
==1888==    by 0x48EA3FF: l_ascii_strdown (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x4CD4DF: sim_parse_language_list (simutil.c:1853)
==1888==    by 0x4C236F: sim_efpl_read_cb (sim.c:2456)
==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
==1888==    by 0x422907: read_generic_cb (sim.c:221)
==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
==1888==    by 0x41AF87: __rx_message (qmi.c:863)
==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x49B0E7: event_check (main.c:196)
==1888==  Address 0x5fd229a is 0 bytes after a block of size 10 alloc'd
==1888==    at 0x486D6C4: calloc (vg_replace_malloc.c:1328)
==1888==    by 0x4E24D7: sim_fs_op_read_block (simfs.c:443)
==1888==    by 0x4A333C3: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
==1888==    by 0x4A36647: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
==1888==    by 0x4A370AF: g_main_loop_run (in /usr/lib64/libglib-2.0.so.
0.7800.4)
==1888==    by 0x41421F: main (main.c:314)
==1888== 
==1888== Invalid read of size 1
==1888==    at 0x486EA2C: strlen (vg_replace_strmem.c:494)
==1888==    by 0x48EA3FF: l_ascii_strdown (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x4CD4DF: sim_parse_language_list (simutil.c:1853)
==1888==    by 0x4C23EF: sim_efpl_read_cb (sim.c:2463)
==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
==1888==    by 0x422907: read_generic_cb (sim.c:221)
==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
==1888==    by 0x41AF87: __rx_message (qmi.c:863)
==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x49B0E7: event_check (main.c:196)
==1888==  Address 0x5fcd46a is 0 bytes after a block of size 10 alloc'd
==1888==    at 0x48687E8: malloc (vg_replace_malloc.c:381)
==1888==    by 0x4A3D29F: g_malloc (in /usr/lib64/libglib-2.0.so.0.7800.4)
==1888==    by 0x4A5781B: g_memdup2 (in /usr/lib64/libglib-2.0.so.0.7800.4)
==1888==    by 0x4C0C27: sim_efli_read_cb (sim.c:2381)
==1888==    by 0x4C0C27: sim_efli_read_cb (sim.c:2372)
==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
==1888==    by 0x422907: read_generic_cb (sim.c:221)
==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
==1888==    by 0x41AF87: __rx_message (qmi.c:863)
==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x49B0E7: event_check (main.c:196)
==1888== 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_query_passwd_state() 
ofonod[1888]: drivers/qmimodem/sim.c:query_passwd_state_cb() passwd state 0
ofonod[1888]: src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 0
ofonod[1888]: drivers/qmimodem/sim.c:qmi_query_pin_retries() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fae path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fad path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:query_pin_retries_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x6fad path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, 
tocopy: 4
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f16 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f38 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x6f38 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, 
tocopy: 12
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f56 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x6f56 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, 
tocopy: 1
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_imsi() 
ofonod[1888]: drivers/qmimodem/sim.c:get_imsi_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_transparent() file id 0x6f07 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: src/sim.c:ofono_sim_add_spn_watch() 0x5eeec00
ofonod[1888]: src/slot-manager.c:slot_manager_update_modem_paths() Default 
voice SIM at /quectelqmi_0
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_signal_string() 
DefaultVoiceModemChanged /quectelqmi_0
ofonod[1888]: plugins/hfp_ag_bluez5.c:update_profile_registration() Registering 
HFP AG profile
ofonod[1888]: plugins/bluez5.c:bt_register_profile() Bluetooth: Registering 
0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
ofonod[1888]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[1888]: plugins/gobi.c:gobi_post_sim() 0x5d50280
ofonod[1888]: drivers/qmimodem/lte.c:qmimodem_lte_probe() qmimodem lte probe
ofonod[1888]: drivers/qmimodem/radio-settings.c:qmi_radio_settings_probe() 
ofonod[1888]: drivers/qmimodem/sms.c:qmi_sms_probe() 
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
ForceSimLegacy
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
NumPremuxInterfaces
ofonod[1888]: drivers/qmimodem/gprs.c:qmi_gprs_probe() 
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
NetworkInterface
ofonod[1888]: drivers/qmimodem/gprs-context.c:qmi_gprs_context_probe() 
ofonod[1888]: plugins/gobi.c:gobi_slot_set_sim_state() gobi_slot_set_sim_state
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
AlwaysOnline
ofonod[1888]: drivers/qmimodem/radio-settings.c:create_dms_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fca path 
len 0
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
AlwaysOnline
ofonod[1888]: plugins/gobi.c:gobi_set_online() 0x5d50280 online using_mux: no
ofonod[1888]: plugins/gobi.c:powered_up_cb() error: 0
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
SystemPath
ofonod[1888]: plugins/bluez5.c:profile_register_cb() 
ofonod[1888]: drivers/qmimodem/lte.c:create_wds_cb() 
ofonod[1888]: drivers/qmimodem/gprs-context.c:create_wds_cb() 
ofonod[1888]: drivers/qmimodem/radio-settings.c:create_nas_cb() 
ofonod[1888]: src/radio-settings.c:radio_load_settings() TechnologyPreference: 
2
ofonod[1888]: src/radio-settings.c:radio_load_settings() GsmBand: 0
ofonod[1888]: src/radio-settings.c:radio_load_settings() UmtsBand: 0
ofonod[1888]: drivers/qmimodem/radio-settings.c:qmi_set_rat_mode() 
ofonod[1888]: drivers/qmimodem/gprs.c:create_nas_cb() 
ofonod[1888]: drivers/qmimodem/gprs.c:create_wds_cb() 
ofonod[1888]: src/sailfish_watch.c:ofono_watch_gprs_notify() quectelqmi_0 gprs 
registered
ofonod[1888]: plugins/bluez5.c:bt_register_profile() Bluetooth: Registering 
00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[1888]: drivers/qmimodem/sms.c:create_wms_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: plugins/bluez5.c:profile_register_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fca path len 
0
ofonod[1888]: plugins/gobi.c:set_online_cb() 
ofonod[1888]: src/slot-manager.c:slot_manager_update_modem_paths() Default 
data SIM at /quectelqmi_0
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_signal_string() 
DefaultDataModemChanged /quectelqmi_0
ofonod[1888]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[1888]: plugins/gobi.c:gobi_post_online() 0x5d50280
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_netreg_probe() 
ofonod[1888]: drivers/qmimodem/netmon.c:qmi_netmon_probe() 
ofonod[1888]: drivers/qmimodem/ussd.c:qmi_ussd_probe() 
ofonod[1888]: drivers/qmimodem/call-settings.c:qmi_call_settings_probe() 
ofonod[1888]: drivers/qmimodem/call-barring.c:qmi_call_barring_probe() 
ofonod[1888]: drivers/qmimodem/call-forwarding.c:qmi_call_forwarding_probe() 
ofonod[1888]: drivers/qmimodem/network-registration.c:create_nas_cb() 
ofonod[1888]: drivers/qmimodem/netmon.c:create_nas_cb() 
ofonod[1888]: drivers/qmimodem/ussd.c:create_voice_cb() 
ofonod[1888]: drivers/qmimodem/call-settings.c:create_voice_cb() 
ofonod[1888]: drivers/qmimodem/call-barring.c:create_voice_cb() 
ofonod[1888]: drivers/qmimodem/call-forwarding.c:create_voice_cb() 
ofonod[1888]: drivers/qmimodem/lte.c:get_default_profile_cb() 
ofonod[1888]: drivers/qmimodem/lte.c:get_default_profile_cb() Default profile 
index: 1
ofonod[1888]: drivers/qmimodem/radio-settings.c:set_system_selection_pref_cb() 
ofonod[1888]: drivers/qmimodem/gprs.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 0
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
unregistered (0)
ofonod[1888]: src/gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
ofonod[1888]: drivers/qmimodem/sms.c:set_event_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fca path len 
0
ofonod[1888]: drivers/qmimodem/network-registration.c:set_event_report_cb() 
ofonod[1888]: drivers/qmimodem/lte.c:reset_profile_cb() 
ofonod[1888]: drivers/qmimodem/lte.c:qmimodem_lte_set_default_attach_info() 
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() 
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() found 6 routes
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() type 0 class 0 => type 1 
value 3
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() type 0 class 1 => type 1 
value 1
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() type 0 class 2 => type 0 
value 1
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() type 0 class 3 => type 1 
value 1
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() type 0 class 4 => type 1 
value 1
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() type 0 class 5 => type 1 
value 1
ofonod[1888]: drivers/qmimodem/sms.c:get_routes_cb() transfer status report 0
ofonod[1888]: drivers/qmimodem/network-
registration.c:qmi_registration_status() 
ofonod[1888]: src/sim.c:ofono_sim_add_spn_watch() 0x5eeec00
ofonod[1888]: src/network.c:__ofono_netreg_add_status_watch() 0x60943f0
ofonod[1888]: src/sailfish_watch.c:ofono_watch_netreg_notify() quectelqmi_0 
netreg registered
ofonod[1888]: src/network.c:__ofono_netreg_add_status_watch() 0x60943f0
ofonod[1888]: src/sim-info.c:sim_info_set_netreg() quectelqmi_0 netreg 
attached
ofonod[1888]: src/network.c:__ofono_netreg_add_status_watch() 0x60943f0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fca path len 
0
ofonod[1888]: drivers/qmimodem/lte.c:modify_profile_cb() 
ofonod[1888]: drivers/qmimodem/sms.c:set_routes_cb() 
ofonod[1888]: src/network.c:__ofono_netreg_add_status_watch() 0x60943f0
ofonod[1888]: drivers/qmimodem/sms.c:qmi_bearer_set() bearer 3
ofonod[1888]: src/sms.c:sms_restore_tx_queue() 
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_sms_watch() registered
ofonod[1888]: src/sms.c:__ofono_sms_datagram_watch_add() 0x602f240: dst -1, 
src -1
ofonod[1888]: plugins/push-notification.c:sms_watch() registered
ofonod[1888]: plugins/smart-messaging.c:sms_watch() registered
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() 
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() delete msg tag 0 mode 0
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() 
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() delete msg tag 2 mode 0
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() 
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() delete msg tag 0 mode 1
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() 
ofonod[1888]: drivers/qmimodem/sms.c:delete_msg() delete msg tag 2 mode 1
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_protocol() 
ofonod[1888]: drivers/qmimodem/network-registration.c:get_ss_info_cb() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
serving system status 2
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() radio 
in use 0
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
roaming 2 lac -1 cellid -1 tech -1
ofonod[1888]: src/network.c:ofono_netreg_status_notify() /quectelqmi_0 status 
2 tech -1 lac -1 ci -1
ofonod[1888]: src/network.c:current_operator_callback() 0x60943f0, (nil)
ofonod[1888]: src/gprs.c:netreg_status_changed() 2 (searching)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() signal 
with 20%(-88 dBm) on 5
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fca path len 
0
ofonod[1888]: drivers/qmimodem/sms.c:qmi_sca_query() 
ofonod[1888]: src/sms.c:__ofono_sms_datagram_watch_add() 0x602f240: dst 9204, 
src -1
ofonod[1888]: src/sms.c:__ofono_sms_datagram_watch_add() 0x602f240: dst 9205, 
src -1
ofonod[1888]: drivers/qmimodem/gprs.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
unregistered (0)
ofonod[1888]: src/gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
ofonod[1888]: drivers/qmimodem/network-registration.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
serving system status 2
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() radio 
in use 5
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() i" 
(234:020)
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
roaming 2 lac -1 cellid -1 tech 2
ofonod[1888]: src/network.c:ofono_netreg_status_notify() /quectelqmi_0 status 
2 tech 2 lac -1 ci -1
ofonod[1888]: src/network.c:current_operator_callback() 0x60943f0, (nil)
ofonod[1888]: src/gprs.c:netreg_status_changed() 2 (searching)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() rat 5 
band 80 channel 10564
ofonod[1888]: drivers/qmimodem/network-registration.c:signal_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/gprs.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
unregistered (0)
ofonod[1888]: src/gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
ofonod[1888]: drivers/qmimodem/network-registration.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
serving system status 2
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() radio 
in use 5
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() i" 
(234:020)
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
roaming 2 lac -1 cellid -1 tech 2
ofonod[1888]: src/network.c:ofono_netreg_status_notify() /quectelqmi_0 status 
2 tech 2 lac -1 ci -1
ofonod[1888]: src/network.c:current_operator_callback() 0x60943f0, (nil)
ofonod[1888]: src/gprs.c:netreg_status_changed() 2 (searching)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/gprs.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 3
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 4
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 5
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
unregistered (0)
ofonod[1888]: src/gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
ofonod[1888]: drivers/qmimodem/network-registration.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
serving system status 1
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() radio 
in use 5
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() i" 
(234:020)
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
roaming 0 lac 1235 cellid 11988180 tech 2
ofonod[1888]: src/network.c:ofono_netreg_status_notify() /quectelqmi_0 status 
1 tech 2 lac 1235 ci 11988180
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_current_operator() 
ofonod[1888]: src/network.c:current_operator_callback() 0x60943f0, (nil)
ofonod[1888]: src/gprs.c:netreg_status_changed() 1 (registered)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 1, driver_attached: 0
ofonod[1888]: drivers/qmimodem/gprs.c:qmi_set_attached() attached 1
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_signal_strength() 
ofonod[1888]: src/gprs.c:netreg_status_changed() 1 (registered)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 1, driver_attached: 1
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() rat 5 
band 80 channel 10564
ofonod[1888]: drivers/qmimodem/sms.c:set_domain_pref_cb() 
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_protocol_cb() 
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_protocol_cb() query both CDMA and 
WCDMA
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_list() 
ofonod[1888]: drivers/qmimodem/sms.c:get_smsc_addr_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fca path len 
0
ofonod[1888]: drivers/qmimodem/gprs.c:attach_detach_cb() 
ofonod[1888]: src/gprs.c:gprs_attach_callback() /quectelqmi_0 error = 0
ofonod[1888]: drivers/qmimodem/gprs.c:qmi_attached_status() 
ofonod[1888]: drivers/qmimodem/network-registration.c:get_rssi_cb() 
ofonod[1888]: drivers/qmimodem/network-registration.c:get_rssi_cb() signal 
with -88 dBm on 5
ofonod[1888]: src/network.c:ofono_netreg_strength_notify() strength 20
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_list_cb() 
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_list_cb() Err: get msg list 
mode=0 47=UNKNOWN
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_list() 
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fc9 path 
len 0
ofonod[1888]: drivers/qmimodem/gprs.c:get_ss_info_cb() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 3
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 4
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 5
ofonod[1888]: src/gprs.c:registration_status_cb() /quectelqmi_0 error 0 status 
0
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
unregistered (0)
ofonod[1888]: src/gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_list_cb() 
ofonod[1888]: drivers/qmimodem/sms.c:get_msg_list_cb() msgs found 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc9 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc9 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc9 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc9 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc9 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f11 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f40 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6f40 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6f40 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6f40 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6f40 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6f40 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6f40 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f46 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x4f20 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fcb path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fcb path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fcb path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fcb path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fcb path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fcb path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f15 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6fc7 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc7 path len 
0
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_record() file id 0x6fc7 path len 
0
ofonod[1888]: drivers/qmimodem/sim.c:read_generic_cb() 
ofonod[1888]: drivers/qmimodem/sim.c:qmi_read_attributes() file id 0x6f14 path 
len 0
ofonod[1888]: drivers/qmimodem/sim.c:get_file_attributes_cb() 
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/gprs.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 3
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 4
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 5
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
registered (1)
ofonod[1888]: drivers/qmimodem/network-registration.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
serving system status 1
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() radio 
in use 5
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
roaming 2 lac -1 cellid -1 tech 2
ofonod[1888]: src/network.c:ofono_netreg_status_notify() /quectelqmi_0 status 
1 tech 2 lac 1235 ci 11988180
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_current_operator() 
ofonod[1888]: src/network.c:current_operator_callback() 0x60943f0, 0x6221c90
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_signal_strength() 
ofonod[1888]: src/gprs.c:netreg_status_changed() 1 (registered)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 1, driver_attached: 1
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3d len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3e len 
0x0004
ofonod[1888]: drivers/qmimodem/network-registration.c:get_rssi_cb() 
ofonod[1888]: drivers/qmimodem/network-registration.c:get_rssi_cb() signal 
with -88 dBm on 5
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3d len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3e len 
0x0004
ofonod[1888]: drivers/qmimodem/gprs.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/gprs.c:handle_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_ss_info() radio in use 5
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() 
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 3
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 4
ofonod[1888]: drivers/qmimodem/gprs.c:extract_dc_info() radio tech in use 5
ofonod[1888]: src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status 
registered (1)
ofonod[1888]: drivers/qmimodem/network-registration.c:ss_info_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
serving system status 1
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() radio 
in use 5
ofonod[1888]: drivers/qmimodem/network-registration.c:extract_ss_info() 
roaming 2 lac -1 cellid 11988233 tech 2
ofonod[1888]: src/network.c:ofono_netreg_status_notify() /quectelqmi_0 status 
1 tech 2 lac 1235 ci 11988233
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_current_operator() 
ofonod[1888]: src/network.c:current_operator_callback() 0x60943f0, 0x6221c90
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_signal_strength() 
ofonod[1888]: src/gprs.c:netreg_status_changed() 1 (registered)
ofonod[1888]: src/gprs.c:gprs_netreg_update() attach: 1, driver_attached: 1
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3d len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3e len 
0x0004
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() 
ofonod[1888]: drivers/qmimodem/network-registration.c:event_notify() rat 5 
band 80 channel 10612
ofonod[1888]: drivers/qmimodem/network-registration.c:get_rssi_cb() 
ofonod[1888]: drivers/qmimodem/network-registration.c:get_rssi_cb() signal 
with -88 dBm on 5
ofonod[1888]: drivers/qmimodem/network-registration.c:system_info_notify() 
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 
0x0003
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 
0x0021
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 
0x0006
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 
0x0008
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x23 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x29 len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x2e len 
0x0001
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x33 len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3d len 
0x0004
ofonod[1888]: drivers/qmimodem/qmi.c:qmi_result_print_tlvs() tlv: 0x3e len 
0x0004
ofonod[1888]: drivers/qmimodem/voicecall.c:all_call_status_ind() 
ofonod[1888]: drivers/qmimodem/voicecall.c:all_call_status_ind() Call 1 in 
state QMI_VOICE_CALL_STATE_SETUP(10)
ofonod[1888]: drivers/qmimodem/voicecall.c:ofono_call_list_notify() Notify new 
call 1
ofonod[1888]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, 
status: incoming (4), id: 1, number: 01697361760 called_number: , called_name 
ofonod[1888]: src/voicecall.c:ofono_voicecall_notify() Did not find a call with 
id: 1
ofonod[1888]: drivers/qmimodem/voicecall.c:all_call_status_ind() 
ofonod[1888]: drivers/qmimodem/voicecall.c:all_call_status_ind() Call 1 in 
state QMI_VOICE_CALL_STATE_INCOMING(2)
ofonod[1888]: drivers/qmimodem/voicecall.c:answer() 
ofonod[1888]: drivers/qmimodem/voicecall.c:answer_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:answer_cb() Received answer result 
with call id 1
ofonod[1888]: drivers/qmimodem/voicecall.c:all_call_status_ind() 
ofonod[1888]: drivers/qmimodem/voicecall.c:all_call_status_ind() Call 1 in 
state QMI_VOICE_CALL_STATE_CONV(3)
ofonod[1888]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, 
status: active (0), id: 1, number: 01697361760 called_number: , called_name 
ofonod[1888]: src/voicecall.c:ofono_voicecall_notify() Found call with id: 1
ofonod[1888]: drivers/qmimodem/voicecall.c:send_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf() 
ofonod[1888]: drivers/qmimodem/voicecall.c:start_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:stop_cont_dtmf_cb() 
ofonod[1888]: drivers/qmimodem/voicecall.c:send_one_dtmf_cb() 
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.0
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.3/ttyUSB3/tty/ttyUSB3
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.4/usbmisc/cdc-wdm0
ofonod[1888]: plugins/udevng.c:destroy_modem() /sys/devices/platform/
fe3c0000.usb/usb1/1-1
ofonod[1888]: src/modem.c:ofono_modem_remove() 0x5d50280
ofonod[1888]: src/modem.c:modem_unregister() 0x5d50280
ofonod[1888]: src/modem.c:modem_change_state() old state: 3, new state: 0
ofonod[1888]: src/modem.c:flush_atoms() 
ofonod[1888]: src/call-forwarding.c:call_forwarding_remove() atom: 0x60a0780
ofonod[1888]: drivers/qmimodem/call-forwarding.c:qmi_call_forwarding_remove() 
ofonod[1888]: src/call-barring.c:call_barring_remove() atom: 0x609e0a0
ofonod[1888]: drivers/qmimodem/call-barring.c:qmi_call_barring_remove() 
ofonod[1888]: src/call-settings.c:call_settings_remove() atom: 0x609b9c0
ofonod[1888]: drivers/qmimodem/call-settings.c:qmi_call_settings_remove() 
ofonod[1888]: src/ussd.c:ussd_remove() atom: 0x6099300
ofonod[1888]: drivers/qmimodem/ussd.c:qmi_ussd_remove() 
ofonod[1888]: drivers/qmimodem/netmon.c:qmi_netmon_remove() 
ofonod[1888]: src/sailfish_watch.c:ofono_watch_netreg_notify() quectelqmi_0 
netreg unregistered
ofonod[1888]: src/network.c:__ofono_netreg_remove_status_watch() 0x60943f0
ofonod[1888]: src/network.c:__ofono_netreg_remove_status_watch() 0x60943f0
ofonod[1888]: src/sim-info.c:sim_info_set_netreg() quectelqmi_0 netreg 
detached
ofonod[1888]: src/sim.c:ofono_sim_remove_spn_watch() 0x5eeec00
ofonod[1888]: src/network.c:netreg_remove() atom: 0x60944e0
ofonod[1888]: drivers/qmimodem/network-registration.c:qmi_netreg_remove() 
ofonod[1888]: src/gprs.c:gprs_context_unregister() 0x603bb10, 0x60370d0
ofonod[1888]: src/gprs.c:gprs_context_remove() atom: 0x603bb90
ofonod[1888]: drivers/qmimodem/gprs-context.c:qmi_gprs_context_remove() 
ofonod[1888]: src/sailfish_watch.c:ofono_watch_gprs_notify() quectelqmi_0 gprs 
unregistered
ofonod[1888]: plugins/bluez5.c:bt_unregister_profile() Bluetooth: Unregistering 
profile /bluetooth/profile/dun_gw
ofonod[1888]: src/gprs.c:gprs_unregister() 0x60370d0
ofonod[1888]: src/gprs.c:gprs_remove() atom: 0x60371b0
ofonod[1888]: drivers/qmimodem/gprs.c:qmi_gprs_remove() 
ofonod[1888]: src/message-waiting.c:mw_remove() atom: 0x6034240
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_sms_watch() unregistered
ofonod[1888]: plugins/push-notification.c:push_notification_cleanup() 0x5d98e20
ofonod[1888]: plugins/smart-messaging.c:smart_messaging_cleanup() 0x5d969c0
ofonod[1888]: src/smsagent.c:sms_agent_send_noreply() Sending: 
'org.ofono.SmartMessagingAgent.Release' to ':1.105' at '/commhistoryd/
SmartMessagingAgent/quectelqmi_0'
ofonod[1888]: src/sms.c:sms_remove() atom: 0x602f390
ofonod[1888]: drivers/qmimodem/sms.c:qmi_sms_remove() 
ofonod[1888]: src/radio-settings.c:radio_settings_remove() atom: 0x602c930
ofonod[1888]: drivers/qmimodem/radio-settings.c:qmi_radio_settings_remove() 
ofonod[1888]: src/lte.c:lte_remove() atom: 0x602a030
ofonod[1888]: drivers/qmimodem/lte.c:qmimodem_lte_remove() 
ofonod[1888]: plugins/hfp_ag_bluez5.c:voicecall_watch() 
ofonod[1888]: plugins/hfp_ag_bluez5.c:update_profile_registration() 
Unregistering HFP AG profile
ofonod[1888]: plugins/bluez5.c:bt_unregister_profile() Bluetooth: Unregistering 
profile /bluetooth/profile/hfp_ag
ofonod[1888]: src/voicecall.c:voicecall_remove() atom: 0x5ef1540
ofonod[1888]: drivers/qmimodem/voicecall.c:qmi_voicecall_remove() 
ofonod[1888]: src/sailfish_watch.c:ofono_watch_sim_notify() quectelqmi_0 sim 
unregistered
ofonod[1888]: src/sim.c:ofono_sim_remove_spn_watch() 0x5eeec00
ofonod[1888]: src/sim-info.c:sim_info_iccid_watch_cb() quectelqmi_0 (null)
ofonod[1888]: src/sim-info.c:sim_info_set_iccid() quectelqmi_0 no more iccid
ofonod[1888]: src/sim-info.c:sim_info_update_public_spn() quectelqmi_0 no 
public spn
ofonod[1888]: src/slot-manager.c:slot_manager_update_modem_paths() No default 
voice SIM
ofonod[1888]: src/slot-manager.c:slot_manager_update_modem_paths() No default 
data SIM
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_signal_string() 
DefaultVoiceModemChanged 
ofonod[1888]: src/slot-manager-dbus.c:slot_manager_dbus_signal_string() 
DefaultDataModemChanged 
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_sim_watch() unregistered
ofonod[1888]: plugins/hfp_ag_bluez5.c:sim_watch() 
ofonod[1888]: src/sim.c:sim_remove() atom: 0x5eeee00
ofonod[1888]: drivers/qmimodem/sim.c:qmi_sim_remove() 
ofonod[1888]: src/modem.c:devinfo_remove() atom: 0x5eea2a0
ofonod[1888]: drivers/qmimodem/devinfo.c:qmi_devinfo_remove() 
ofonod[1888]: plugins/gobi.c:gobi_disable() 0x5d50280
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5d50280 property 
AlwaysOnline
ofonod[1888]: plugins/gobi.c:gobi_remove() 0x5d50280
ofonod[1888]: plugins/gobi.c:gobi_slot_driver_cleanup() 
gobi_slot_driver_cleanup
ofonod[1888]: src/modem.c:unregister_property() property 0x5d6d5d0
ofonod[1888]: src/modem.c:unregister_property() property 0x5d66920
ofonod[1888]: src/modem.c:unregister_property() property 0x5d6b1a0
ofonod[1888]: src/modem.c:unregister_property() property 0x5d644f0
ofonod[1888]: src/modem.c:unregister_property() property 0x5d6fa50
ofonod[1888]: src/modem.c:unregister_property() property 0x5d62040
ofonod[1888]: src/modem.c:unregister_property() property 0x5d68d60
ofonod[1888]: src/modem.c:emit_modem_removed() 0x5d50280
ofonod[1888]: src/modem.c:call_modemwatches() 0x5d50280 added:0
ofonod[1888]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x5d50280, added: 0
ofonod[1888]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x5d50280, added: 0
ofonod[1888]: plugins/hfp_ag_bluez5.c:modem_watch() Removing modem 0x5d50280, 
info: 0x5d8fc60
ofonod[1888]: plugins/sailfish_bt.c:modem_watch() modem: 0x5d50280, added: 0
ofonod[1888]: plugins/smart-messaging.c:modem_watch() modem: 0x5d50280, added: 
0
ofonod[1888]: plugins/push-notification.c:modem_watch() modem: 0x5d50280, 
added: 0
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_modem_watch() modem: 
0x5d50280, added: 0
ofonod[1888]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm0
ofonod[1888]: plugins/udevng.c:destroy_modem() wwan0
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.2
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.1
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.4/net/wwan0
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.3
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1/1-1:1.4
ofonod[1888]: plugins/udevng.c:remove_device() /sys/devices/platform/
fe3c0000.usb/usb1/1-1
ofonod[1888]: plugins/bluez5.c:unregister_profile_cb() 
ofonod[1888]: plugins/bluez5.c:unregister_profile_cb() 
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: src/modem.c:get_modem_property() modem 0x5e2a410 property 
SystemPath
ofonod[1888]: plugins/udevng.c:check_usb_device() usb [1d6b:0002]
ofonod[1888]: plugins/udevng.c:check_usb_device() usb [18d1:d00d]
ofonod[1888]: plugins/udevng.c:check_modem_list() 
^Cofonod[1888]: Terminating
ofonod[1888]: src/plugin.c:__ofono_plugin_cleanup() 
ofonod[1888]: plugins/sailfish_pushforwarder.c:pf_plugin_exit() 
ofonod[1888]: plugins/push-notification.c:push_notification_exit() 
ofonod[1888]: plugins/smart-messaging.c:smart_messaging_exit() 
ofonod[1888]: plugins/sailfish_bt.c:sfos_bt_exit() 
ofonod[1888]: plugins/hfp_ag_bluez5.c:hfp_ag_exit() 
ofonod[1888]: src/handsfree-audio.c:ofono_handsfree_card_driver_unregister() 
driver: 0x5838b0
ofonod[1888]: plugins/bluez5.c:bt_unregister_profile() Bluetooth: Unregistering 
profile /bluetooth/profile/dun_gw
ofonod[1888]: plugins/bluez5.c:bt_unregister_profile() Bluetooth: Unregistering 
profile /bluetooth/profile/hfp_hf
ofonod[1888]: src/handsfree-audio.c:ofono_handsfree_card_driver_unregister() 
driver: 0x583780
ofonod[1888]: src/modem.c:ofono_modem_remove() 0x5e2a410
ofonod[1888]: src/modem.c:modem_unregister() 0x5e2a410
ofonod[1888]: plugins/hfp_hf_bluez5.c:hfp_remove() modem: 0x5e2a410
ofonod[1888]: src/modem.c:unregister_property() property 0x5e2caf0
ofonod[1888]: src/modem.c:unregister_property() property 0x5e2efb0
ofonod[1888]: src/modem.c:emit_modem_removed() 0x5e2a410
ofonod[1888]: src/modem.c:call_modemwatches() 0x5e2a410 added:0
ofonod[1888]: src/private-network.c:ofono_private_network_driver_unregister() 
driver: 0x583728, name: ConnMan Private Network
ofonod[1888]: plugins/sailfish_access.c:sailfish_access_exit() 
ofonod[1888]: src/dbus-access.c:ofono_dbus_access_plugin_unregister() Sailfish 
D-Bus access
src/module.c:__ofono_modules_cleanup() 
ofonod[1888]: Exit
==1888== 
==1888== HEAP SUMMARY:
==1888==     in use at exit: 91,861 bytes in 589 blocks
==1888==   total heap usage: 42,863 allocs, 42,274 frees, 14,151,095 bytes 
allocated
==1888== 
==1888== 2 bytes in 1 blocks are definitely lost in loss record 1 of 521
==1888==    at 0x48687E8: malloc (vg_replace_malloc.c:381)
==1888==    by 0x4D3299F: strndup (strndup.c:43)
==1888==    by 0x48E8FC7: l_strndup (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x42CEE3: gobi_get_ids_cb (gobi.c:129)
==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
==1888==    by 0x41AF87: __rx_message (qmi.c:863)
==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
==1888==    by 0x49B0E7: event_check (main.c:196)
==1888==    by 0x4A363AF: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
==1888==    by 0x4A3659B: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
==1888== 
==1888== LEAK SUMMARY:
==1888==    definitely lost: 2 bytes in 1 blocks
==1888==    indirectly lost: 0 bytes in 0 blocks
==1888==      possibly lost: 0 bytes in 0 blocks
==1888==    still reachable: 88,451 bytes in 554 blocks
==1888==         suppressed: 0 bytes in 0 blocks
==1888== Reachable blocks (those to which a pointer was found) are not shown.
==1888== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==1888== 
==1888== For lists of detected and suppressed errors, rerun with: -s
==1888== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)




On Friday 26 April 2024 22:26:33 BST Adam Pigg wrote:
> This version of the DTMF code goes back to V4, but adds in some of the
> changes in v5 to store the cb and data for the core ofono callback.
> 
> I have tested this with individual digits and a string of 10 digits 0-9
> using the dbus api.
> 
> I have also ran this through valgrind, once in the normal path, and again
> running an AT command against the modem to reboot it into fastboot mode to
> simulate removal.  Both cases found no leaks.
> 
> Hopefully this is getting closer!
> 
> Thanks
> 
> Adam
> 
> On Friday 26 April 2024 22:22:03 BST Adam Pigg wrote:
> > The send_dtmf function sets up a call to send_one_dtmf, which will call
> > the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The parameters to
> > this call are a hard coded call-id and the DTMF character to send.
> > start_cont_dtmf_cb will then be called which will set up a call to
> > QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
> > stop_cont_dtmf_cb will check the final status.
> > 
> > ---
> > Changes in V4
> > -Removed unused enum
> > -Minor formatting fixes
> > -Ensure data->full_dtmf is free'd
> > -Use cb_data_ref/unref between chains of dtmf calls
> > 
> > Changes in V5/V6
> > -Store the core cb and cbd obejects in the voicall_data struct
> > -Fix incorrect free calls
> > ---
> > ---
> > 
> >  drivers/qmimodem/voice.h     |   6 ++
> >  drivers/qmimodem/voicecall.c | 127 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 133 insertions(+)
> > 
> > diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> > index caedb079..92186b72 100644
> > --- a/drivers/qmimodem/voice.h
> > +++ b/drivers/qmimodem/voice.h
> > @@ -53,6 +53,8 @@ enum voice_commands {
> > 
> >  	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
> >  	QMI_VOICE_END_CALL =			0x21,
> >  	QMI_VOICE_ANSWER_CALL =			0x22,
> > 
> > +	QMI_VOICE_START_CONTINUOUS_DTMF =       0x29,
> > +	QMI_VOICE_STOP_CONTINUOUS_DTMF =        0x2A,
> > 
> >  	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
> >  	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
> >  	QMI_VOICE_GET_CALL_WAITING =		0x34,
> > 
> > @@ -85,6 +87,10 @@ enum qmi_voice_call_state {
> > 
> >  	QMI_VOICE_CALL_STATE_SETUP
> >  
> >  };
> > 
> > +enum qmi_voice_call_dtmf_param {
> > +	QMI_VOICE_DTMF_DATA = 0x01,
> > +};
> > +
> > 
> >  struct qmi_ussd_data {
> >  
> >  	uint8_t dcs;
> >  	uint8_t length;
> > 
> > diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> > index 7c9326fe..0df65226 100644
> > --- a/drivers/qmimodem/voicecall.c
> > +++ b/drivers/qmimodem/voicecall.c
> > @@ -42,6 +42,10 @@ struct voicecall_data {
> > 
> >  	uint16_t minor;
> >  	struct l_queue *call_list;
> >  	struct ofono_phone_number dialed;
> > 
> > +	char *full_dtmf;
> > +	const char *next_dtmf;
> > +	ofono_voicecall_cb_t send_dtmf_cb;
> > +	struct cb_data *send_dtmf_data;
> > 
> >  };
> >  
> >  struct qmi_voice_call_information_instance {
> > 
> > @@ -599,6 +603,127 @@ static void hangup_active(struct ofono_voicecall
> > *vc,
> > ofono_voicecall_cb_t cb, release_specific(vc, call->id, cb, data);
> > 
> >  }
> > 
> > +static void stop_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> > +{
> > +	struct cb_data *cbd = user_data;
> > +	ofono_voicecall_cb_t cb = cbd->cb;
> > +
> > +	uint16_t error;
> > +
> > +	DBG("");
> > +
> > +	if (qmi_result_set_error(result, &error)) {
> > +		DBG("QMI Error %d", error);
> > +		CALLBACK_WITH_FAILURE(cb, cbd);
> > +		return;
> > +	}
> > +
> > +	CALLBACK_WITH_SUCCESS(cb, cbd);
> > +}
> > +
> > +static void start_cont_dtmf_cb(struct qmi_result *result, void
> > *user_data)
> > +{
> > +	struct cb_data *cbd = user_data;
> > +	ofono_voicecall_cb_t cb = cbd->cb;
> > +	struct ofono_voicecall *vc = cbd->user;
> > +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> > +	uint16_t error;
> > +	struct qmi_param *param;
> > +
> > +	DBG("");
> > +
> > +	if (qmi_result_set_error(result, &error)) {
> > +		DBG("QMI Error %d", error);
> > +		CALLBACK_WITH_FAILURE(cb, cbd);
> > +		return;
> > +	}
> > +
> > +	param = qmi_param_new();
> > +
> > +	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
> > +		goto error;
> > +
> > +	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF,
> 
> param,
> 
> > +			stop_cont_dtmf_cb, cbd, cb_data_unref) > 0) 
{
> > +		cb_data_ref(cbd);
> > +		return;
> > +	}
> > +
> > +error:
> > +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> > +	l_free(param);
> > +}
> > +
> > +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> > +				ofono_voicecall_cb_t cb, void
> 
> *data)
> 
> > +{
> > +	struct voicecall_data *vd = data;
> > +	struct qmi_param *param;
> > +	uint8_t param_body[2];
> > +	struct cb_data *cbd = cb_data_new(cb, data);
> > +
> > +	DBG("");
> > +
> > +	cbd->user = vc;
> > +
> > +	param = qmi_param_new();
> > +
> > +	param_body[0] = 0xff;
> > +	param_body[1] = (uint8_t)dtmf;
> > +
> > +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA,
> 
> sizeof(param_body),
> 
> > +			param_body))
> > +		goto error;
> > +
> > +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF,
> 
> param,
> 
> > +			start_cont_dtmf_cb, cbd, cb_data_unref) > 0)
> > +		return;
> > +
> > +error:
> > +	CALLBACK_WITH_FAILURE(cb, data);
> > +	l_free(param);
> > +}
> > +
> > +static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
> > +{
> > +	struct cb_data *cbd = data;
> > +	struct ofono_voicecall *vc = cbd->user;
> > +	struct voicecall_data *vd = cbd->data;
> > +
> > +	DBG("");
> > +
> > +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
> > +			*vd->next_dtmf == 0) {
> > +		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
> > +			CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd-
> >
> >send_dtmf_data);
> >
> > +		else
> > +			CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd-
> >
> >send_dtmf_data);
> >
> > +
> > +		l_free(vd->full_dtmf);
> > +		vd->full_dtmf = NULL;
> > +	} else {
> > +		send_one_dtmf(vc,
> > +				*(vd->next_dtmf++),
> > +				send_one_dtmf_cb, vd);
> > +	}
> > +}
> > +
> > +static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
> > +			ofono_voicecall_cb_t cb, void *data)
> > +{
> > +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> > +
> > +	DBG("");
> > +
> > +	l_free(vd->full_dtmf);
> > +	vd->full_dtmf = l_strdup(dtmf);
> > +	vd->next_dtmf = &vd->full_dtmf[1];
> > +	vd->send_dtmf_data = data;
> > +	vd->send_dtmf_cb = cb;
> > +
> > +	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, vd);
> > +}
> > +
> > 
> >  static void create_voice_cb(struct qmi_service *service, void *user_data)
> >  {
> >  
> >  	struct ofono_voicecall *vc = user_data;
> > 
> > @@ -656,6 +781,7 @@ static void qmi_voicecall_remove(struct
> > ofono_voicecall
> > *vc) qmi_service_free(data->voice);
> > 
> >  	l_queue_destroy(data->call_list, l_free);
> > 
> > +	l_free(data->full_dtmf);
> > 
> >  	l_free(data);
> >  
> >  }
> > 
> > @@ -666,6 +792,7 @@ static const struct ofono_voicecall_driver driver = {
> > 
> >  	.answer		= answer,
> >  	.hangup_active  = hangup_active,
> >  	.release_specific  = release_specific,
> > 
> > +	.send_tones     = send_dtmf,
> > 
> >  };
> >  
> >  OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)




