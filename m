Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0E194C86
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333231; cv=none; b=IjfsvOa6VYcgvZ0/6s2/BwUvwPw3ednTa1RJXrQTiBR39gRXpUXdxfXbiKhSpD/HprumuxXEMVCBQZRudgarKSKrNkbfIBW8BtDP+cdyZjvEvq7WD4sfv/snmCK2iiufqeDfDW9PMIRHLG4eTdbtrgePk885CcB2Kl6N3EpVWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333231; c=relaxed/simple;
	bh=+2hHXzDoZLYRa5Hy0QANji3Ehb+ddvCqAS0cD8i2V4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COx4zBVAaAldr2rya229W4vua+bFDNpVQYkRhXQ0BZdxXWxaqArJfrEIMFdc85YnQug9nrWAxIpBSJRM2Go274FUm4AS8WOr4WnoIDE8CeJBiBj04xVwaxqh8inS4PFbJhPqQoDUDoVHRwuh8Z2iBfaWIjSJiLCsVXKFs+PyKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD+NAfCh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD+NAfCh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3687ea0521cso2586962f8f.1
        for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722333223; x=1722938023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owEBORiez5hqDHq1HEqsW7GhOByRXDftSTIPNM9indo=;
        b=cD+NAfChe8UDlpddxJ9HSgbavR1lG9BhO+O7x/E8Opff4Vzg92WbjjYRNcI2F0TYlq
         bjfE3E8SpI6vJOHdu3zVy+TOWWOhiMvEWHENIKphz8G2F5+yjOBEtpQztqcENW89Wis8
         dYiEf6AvLVqNSTJ7X6vfImDG4lYCotwrCRelcjUi0slIDFfSE9CUWP4OFogjjHhnjgX0
         +B5A10gSf41gaBm9SbfzFpq9npGEWUsB/njVUB04UQbTPfDVVmlKLIuP4CjNYZZxpJhQ
         RiDGpzSX2azObUq0RI4CzEi7HJ6/5WwHzo9DCu8Aw/8H9BOxkFPxag9XUdJ5SX/KqgDt
         bxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333223; x=1722938023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owEBORiez5hqDHq1HEqsW7GhOByRXDftSTIPNM9indo=;
        b=r+RoaB3U+0YQzsbgt/MQMBDw/gXidd9u7pwqemepemvTWUG1qCqRYrDOA3Obh5OrpY
         QYJwLOoK7YTrHMv6WPxtda4Lls+F4cukLnAM7Cd11oKBwaYaKnNTKSk9ihRxqp7NLrCR
         Lk4cbPvvCGDsjImiLex3tHI8trWjj3IV4UvyjV2rwHnqFz8pa1ACPeGBcvOs2peiKvCw
         bLXJoxci3nljyXGKQ4ffULi/b1Qk3j7Db95HI+tB+fzYCPO9KJGO8zMFpSawWKgDKvO6
         ocWvxJoxVdBPkrh17x4LYS8Qt9TB/nQfYcXkt6XoOrn9NjiF8FPA8d1IPCsiaOpbKHSC
         7i0w==
X-Gm-Message-State: AOJu0YwIFJ7ikBS2/hey0AdtHkMJXG5F5c43ECpAeW+noGJRdqViLb1G
	HjD7FxRUCMLUO5rXS+0YlzWOJbrZ+ubxr48F885ST4fpoR1zj6FZIVKgi3LZ
X-Google-Smtp-Source: AGHT+IFLzrBX3s+LbjcN2nMKFtvZNtaR4Zm12OxqdI7brxxllbT/+tDS8QP35c/vLBqtoUc9KTDIYg==
X-Received: by 2002:adf:a31d:0:b0:368:7868:2d76 with SMTP id ffacd0b85a97d-36b5d2c9df1mr7497954f8f.51.1722333221619;
        Tue, 30 Jul 2024 02:53:41 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.116.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0320sm14272689f8f.19.2024.07.30.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:53:40 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject:
 Re: [PATCH] qmi: Allow qmi_qmux_device_discover be called from callback
Date: Tue, 30 Jul 2024 10:53:36 +0100
Message-ID: <2517208.XAFRqVoOGU@adam-laptop-hp>
In-Reply-To: <20240730034738.222227-1-denkenz@gmail.com>
References: <20240730034738.222227-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

On Tuesday 30 July 2024 04:47:12 BST Denis Kenzior wrote:
>  drivers/qmimodem/qmi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index b8f46a5b4a0e..0ba2e8b9e352 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1152,13 +1152,17 @@ static struct qmi_request
> *find_control_request(struct qmi_qmux_device *qmux,
> 
>  static void __qmux_discovery_finished(struct qmi_qmux_device *qmux)
>  {
> +       qmi_qmux_device_discover_func_t func = qmux->discover.func;
> +       void *user_data = qmux->discover.user_data;
> +       qmi_destroy_func_t destroy = qmux->discover.destroy;
> +
>         l_timeout_remove(qmux->discover.timeout);
> -       qmux->discover.func(qmux->discover.user_data);
> +       memset(&qmux->discover, 0, sizeof(qmux->discover));
> 
> -       if (qmux->discover.destroy)
> -               qmux->discover.destroy(qmux->discover.user_data);
> +       func(user_data);
> 
> -       memset(&qmux->discover, 0, sizeof(qmux->discover));
> +       if (destroy)
> +               destroy(user_data);
>  }
> 
>  static void qmux_sync_callback(struct qmi_request *req, uint16_t message,


This certainly seems to improve the situation.  what happens now on boot is 
that the driver loads Ok, the UI shows the signal strength for a few seconds, 
but then appears to go to an unregistered state, which is supported by the 
logs below.  When I restart ofono, it seems to work fine, this log is also 
below.

Thanks

Adam

[root@PinePhone defaultuser]# journalctl -b | grep -i "ofono\|eg25"
Jul 30 10:42:41 PinePhone systemd[1]: Started Quectel EG25 modem.
Jul 30 10:42:41 PinePhone audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=eg25-manager comm="systemd" exe="/usr/lib/systemd/
systemd" hostname=? addr=? terminal=? res=success'
Jul 30 10:42:41 PinePhone eg25-manager[2507]: Opening config file: /usr/share/
eg25-manager/pine64,pinephone-1.2.toml
Jul 30 10:42:41 PinePhone eg25-manager[2507]: Starting modem...
Jul 30 10:42:41 PinePhone ofonod[2543]: oFono version 2.9
Jul 30 10:42:41 PinePhone audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=ofono comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Jul 30 10:42:41 PinePhone ofonod[2543]: src/module.c:__ofono_modules_init()
Jul 30 10:42:41 PinePhone ofonod[2543]: src/manager.c:manager_init() 
manager_init
Jul 30 10:42:41 PinePhone ofonod[2543]: src/provision.c:provision_init()
Jul 30 10:42:41 PinePhone ofonod[2543]: src/slot-
manager.c:ofono_slot_manager_object_init() Default voice sim is (auto)
Jul 30 10:42:41 PinePhone ofonod[2543]: src/slot-
manager.c:ofono_slot_manager_object_init() Default data sim is (auto)
Jul 30 10:42:41 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_set_block() blocking ALL requests
Jul 30 10:42:41 PinePhone ofonod[2543]: src/plugin.c:__ofono_plugin_init()
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring Sailfish D-Bus access plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Excluding Phone Simulator driver
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring ST-Ericsson Modem Init Daemon 
detection
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring ConnMan plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Excluding External Hands-Free Profile 
Plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Excluding Dial-up Networking Profile 
Plugins
Jul 30 10:42:41 PinePhone ofonod[2543]: Excluding BlueZ 5 Utils Plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Excluding Hands-Free Audio Gateway 
Profile Plugins
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring Sailfish OS Bluetooth Plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring upower battery monitor
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring Smart Messaging Plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring Push Notification Plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring Push Forwarder Plugin
Jul 30 10:42:41 PinePhone ofonod[2543]: Ignoring Plugin to read EFACL from SIM
Jul 30 10:42:42 PinePhone ofonod[2543]: Can't load /usr/lib64/ofono/plugins/
amlplugin.so: /usr/lib64/ofono/plugins/amlplugin.so: undefined symbol: 
ofono_voicecall_is_emergency_number
Jul 30 10:42:42 PinePhone ofonod[2543]: plugins/udevng.c:udev_start()
Jul 30 10:42:42 PinePhone ofonod[2543]: plugins/udevng.c:enumerate_devices()
Jul 30 10:42:42 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1a000.usb/usb2
Jul 30 10:42:42 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1a400.usb/usb4
Jul 30 10:42:42 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1
Jul 30 10:42:42 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b400.usb/usb3
Jul 30 10:42:42 PinePhone eg25-manager[2507]: Executed power-on/off sequence
Jul 30 10:42:42 PinePhone eg25-manager[2507]: taking systemd sleep inhibitor
Jul 30 10:42:42 PinePhone eg25-manager[2507]: oFono appeared on D-Bus
Jul 30 10:42:42 PinePhone eg25-manager[2507]: inhibitor sleep fd is 19
Jul 30 10:42:43 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:42:43 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
usb [1d6b:0002]
Jul 30 10:42:44 PinePhone ofonod[2543]: plugins/udevng.c:check_modem_list()
Jul 30 10:42:45 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x10f78670
Jul 30 10:42:48 PinePhone ofonod[2543]: plugins/udevng.c:remove_device() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.0
Jul 30 10:42:48 PinePhone ofonod[2543]: plugins/udevng.c:remove_device() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:43:50 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x10f401d0
Jul 30 10:43:58 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x10f3eec0
Jul 30 10:43:58 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x10f44f90
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
usb [1d6b:0002]
Jul 30 10:44:00 PinePhone eg25-manager[2507]: Response: [RDY]
Jul 30 10:44:00 PinePhone eg25-manager[2507]: taking systemd sleep inhibitor 
(blocking)
Jul 30 10:44:00 PinePhone eg25-manager[2507]: inhibitor block fd is 21
Jul 30 10:44:00 PinePhone eg25-manager[2507]: Response: [+CFUN: 1]
Jul 30 10:44:00 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.4/usbmisc/
cdc-wdm0
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
qmi_wwan [2c7c:0125]
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.4/usbmisc/cdc-wdm0
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() /dev/
cdc-wdm0 (quectelqmi) 255/255/255 [04] ==> (null) (null)
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.1/ttyUSB1/
tty/ttyUSB1
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() /dev/
ttyUSB1 (quectelqmi) 255/0/0 [01] ==> (null) (null)
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.3/ttyUSB3/
tty/ttyUSB3
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.3/ttyUSB3/tty/ttyUSB3
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() /dev/
ttyUSB3 (quectelqmi) 255/0/0 [03] ==> (null) (null)
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.0/ttyUSB0/
tty/ttyUSB0
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() /dev/
ttyUSB0 (quectelqmi) 255/255/255 [00] ==> (null) (null)
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.2/ttyUSB2/
tty/ttyUSB2
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.2/ttyUSB2/tty/ttyUSB2
Jul 30 10:44:00 PinePhone ofonod[2543]: plugins/udevng.c:add_device() /dev/
ttyUSB2 (quectelqmi) 255/0/0 [02] ==> (null) (null)
Jul 30 10:44:01 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.4/net/wwan0
Jul 30 10:44:01 PinePhone ofonod[2543]: plugins/udevng.c:check_usb_device() 
qmi_wwan [2c7c:0125]
Jul 30 10:44:01 PinePhone ofonod[2543]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.4/net/wwan0
Jul 30 10:44:01 PinePhone ofonod[2543]: plugins/udevng.c:add_device() (null) 
(quectelqmi) 255/255/255 [04] ==> (null) (null)
Jul 30 10:44:01 PinePhone eg25-manager[2507]: Response: [+CPIN: 
READY\r\n\r\n+QUSIM: 1]
Jul 30 10:44:01 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:01 PinePhone eg25-manager[2507]: Response: [+QIND: SMS DONE]
Jul 30 10:44:01 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:check_modem_list()
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:create_modem() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:create_modem() 
driver=quectelqmi
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:ofono_modem_create() name: 
(null), type: quectelqmi
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() /
sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB0 255/255/255 00 (null) tty
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB1 255/0/0 01 (null) tty
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB2 255/0/0 02 (null) tty
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB3 255/0/0 03 (null) tty
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() 
(null) 255/255/255 04 (null) net
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() /
dev/cdc-wdm0 255/255/255 04 (null) usbmisc
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_quectelqmi() 
gps=/dev/ttyUSB1 aux=/dev/ttyUSB2
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/udevng.c:setup_qmi_qmux() qmi: 
/dev/cdc-wdm0 net: wwan0 kernel_driver: qmi_wwan interface_number: 04
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:ofono_modem_set_driver() 
type: gobi
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property Device
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property InterfaceNumber
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property Bus
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property NetworkInterfaceKernelDriver
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property NetworkInterface
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property NetworkInterfaceIndex
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property GPS
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property Aux
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:set_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:ofono_modem_register() 
0x10f6d260
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/gobi.c:gobi_probe() 0x10f6d260
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterfaceKernelDriver
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterface
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterfaceIndex
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property Bus
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/gobi.c:gobi_probe() net: 
wwan0[qmi_wwan](4) usb
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterfaceIndex
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterface
Jul 30 10:44:02 PinePhone ofonod[2543]: src/
modem.c:ofono_modem_set_capabilities() 1
Jul 30 10:44:02 PinePhone ofonod[2543]: gobi_slot_plugin_start
Jul 30 10:44:02 PinePhone ofonod[2543]: src/slot-
manager.c:slot_manager_init_countdown_cb() done with registrations
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/gobi.c:gobi_slot_driver_init() 
gobi_slot_driver_init
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/
gobi.c:gobi_slot_driver_start() gobi_slot_driver_start
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:emit_modem_added() 
0x10f6d260
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:call_modemwatches() 
0x10f6d260 added:1
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:02 PinePhone ofonod[2543]: plugins/gobi.c:gobi_enable() 
0x10f6d260
Jul 30 10:44:02 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property Device
Jul 30 10:44:03 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property Aux
Jul 30 10:44:03 PinePhone ofonod[2543]: plugins/gobi.c:gobi_enable() Have 
atmodem
Jul 30 10:44:03 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:03 PinePhone connmand[2627]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 30 10:44:03 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:03 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x10f7abf0
Jul 30 10:44:03 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:03 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:04 PinePhone eg25-manager[2507]: Response: [+QIND: PB DONE]
Jul 30 10:44:04 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:05 PinePhone connmand[2627]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 30 10:44:05 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:07 PinePhone connmand[2627]: [ofonoext] ERROR! Timeout was 
reached
Jul 30 10:44:07 PinePhone connmand[2627]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 30 10:44:08 PinePhone ofonod[2543]: plugins/gobi.c:discover_cb()
Jul 30 10:44:08 PinePhone eg25-manager[2507]: GNSS assistance upload 
started...
Jul 30 10:44:08 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(1/7): fetching assistance data
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Fetching GNSS assistance data 
from https://xtrapath4.izatcloud.net/xtra2.bin was successful
Jul 30 10:44:09 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(2/7): disabling GNSS engine through AT+QGPS
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Executed soft wake sequence
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Successfully sent command: 
AT+QGPS?
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Response: [AT+QGPS?\r\r\n+QGPS: 
0\r\n\r\nOK]
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:09 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(3/7): initiating upload
Jul 30 10:44:09 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x10f7a4a0
Jul 30 10:44:09 PinePhone connmand[2627]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Executed soft wake sequence
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Successfully sent command: 
AT+QFDEL="RAM:*"
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Response: [AT+QFDEL="RAM:*"]
Jul 30 10:44:09 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:discover_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb() 
Requesting: 3
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb() 
Requesting: 1
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb() 
Requesting: 5
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb() 
Requesting: 9
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb() 
Requesting: 11
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:request_service_cb() 
All services requested, proceeding to create WDA
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:create_wda_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_data_format_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterface
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:setup_qmi_wwan() 
raw_ip: N, want: Y
Jul 30 10:44:10 PinePhone ofonod[2543]: Got IMEI 867698042994007
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/
gobi.c:gobi_slot_driver_startup_check() gobi_slot_driver_startup_check
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sailfish_watch.c:ofono_watch_new() 
quectelqmi_0 created
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim-info-
dbus.c:sim_info_dbus_new() /quectelqmi_0
Jul 30 10:44:10 PinePhone ofonod[2543]: src/cell-info-
control.c:cell_info_control_get() /quectelqmi_0 created
Jul 30 10:44:10 PinePhone ofonod[2543]: src/slot-manager.c:slot_add_internal() 
quectelqmi_0
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_caps_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_caps_cb() service 
capabilities 4
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_caps_cb() sim 
supported 2
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_caps_cb() radio = 4
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_caps_cb() radio = 5
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_caps_cb() radio = 8
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:get_oper_mode_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property AlwaysOnline
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:power_reset_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: src/modem.c:modem_change_state() old 
state: 0, new state: 1
Jul 30 10:44:10 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property ForceSimLegacy
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/gobi.c:gobi_pre_sim() 
0x10f6d260
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:qmi_devinfo_probe()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_sim_probev()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
voicecall.c:qmi_voicecall_probe()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
voicecall.c:qmi_voicecall_probe() VOICE AT CHAT REGISTER 1
Jul 30 10:44:10 PinePhone ofonod[2543]: plugins/
gobi.c:gobi_slot_set_sim_state() gobi_slot_set_sim_state
Jul 30 10:44:10 PinePhone ofonod[2543]: src/slot-
manager.c:slot_manager_update_ready() ready
Jul 30 10:44:10 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_set_block() unblocking ALL requests
Jul 30 10:44:10 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_signal_boolean() ReadyChanged 1
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:get_caps_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:qmi_query_manufacturer()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:event_registration_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:event_registration_cb() event mask 0x0003
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/devinfo.c:string_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:qmi_query_model()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_card_status_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_state_watch() 
0x10f76330
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_state_watch() 
0x10f76330
Jul 30 10:44:10 PinePhone ofonod[2543]: src/
sailfish_watch.c:ofono_watch_sim_notify() quectelqmi_0 sim registered
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_state_watch() 
0x10f76330
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_iccid_watch() 
0x10f76330
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_imsi_watch() 
0x10f76330
Jul 30 10:44:10 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_state_watch() 
0x10f76330
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fb7 path len 0
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/devinfo.c:string_cb()
Jul 30 10:44:10 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:qmi_query_revision()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/devinfo.c:string_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:qmi_query_serial()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: Requested file structure differs from 
SIM: 6fb7
Jul 30 10:44:11 PinePhone ofonod[2543]: src/voicecall.c:ecc_g2_read_cb() 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fb7 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
devinfo.c:get_ids_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x2fe2 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x2fe2 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 10
Jul 30 10:44:11 PinePhone ofonod[2543]: src/sim-
info.c:sim_info_iccid_watch_cb() quectelqmi_0 8944200122784036312
Jul 30 10:44:11 PinePhone ofonod[2543]: src/sim-info.c:sim_info_load_cache() 
quectelqmi_0 imsi[8944200122784036312] = 234206313731703
Jul 30 10:44:11 PinePhone ofonod[2543]: src/sim-info.c:sim_info_load_cache() 
quectelqmi_0 no spn for imsi 234206313731703
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f05 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f05 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 10
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x2f05 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x2f05 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 10
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_query_passwd_state()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:query_passwd_state_cb() passwd state 0
Jul 30 10:44:11 PinePhone ofonod[2543]: src/sim.c:sim_pin_query_cb() sim-
>pin_type: 0, pin_type: 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_query_pin_retries()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fae path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fad path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property AlwaysOnline
Jul 30 10:44:11 PinePhone ofonod[2543]: plugins/gobi.c:gobi_set_online() 
0x10f6d260 online using_mux: no
Jul 30 10:44:11 PinePhone ofonod[2543]: plugins/gobi.c:powered_up_cb() error: 
0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:query_pin_retries_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6fad path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: plugins/gobi.c:set_online_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/modem.c:common_online_cb() Online 
in PRE SIM state
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 4
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f16 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f38 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f38 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 12
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f56 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f56 path len 0
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:11 PinePhone ofonod[2543]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 1
Jul 30 10:44:11 PinePhone ofonod[2543]: drivers/qmimodem/sim.c:qmi_read_imsi()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/sim.c:get_imsi_cb()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f07 path len 0
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:12 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_spn_watch() 
0x10f76330
Jul 30 10:44:12 PinePhone ofonod[2543]: src/slot-
manager.c:slot_manager_update_modem_paths() Default voice SIM at /quectelqmi_0
Jul 30 10:44:12 PinePhone ofonod[2543]: src/slot-
manager.c:slot_manager_update_modem_paths() Default data SIM at /quectelqmi_0
Jul 30 10:44:12 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_signal_string() DefaultVoiceModemChanged /
quectelqmi_0
Jul 30 10:44:12 PinePhone ofonod[2543]: src/slot-manager-
dbus.c:slot_manager_dbus_signal_string() DefaultDataModemChanged /quectelqmi_0
Jul 30 10:44:12 PinePhone ofonod[2543]: src/modem.c:modem_change_state() old 
state: 1, new state: 2
Jul 30 10:44:12 PinePhone ofonod[2543]: plugins/gobi.c:gobi_post_sim() 
0x10f6d260
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
lte.c:qmimodem_lte_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/radio-
settings.c:qmi_radio_settings_probev()
Jul 30 10:44:12 PinePhone ofonod[2543]: src/radio-
settings.c:radio_load_settings() TechnologyPreference: 4
Jul 30 10:44:12 PinePhone ofonod[2543]: src/radio-
settings.c:radio_load_settings() GsmBand: 0
Jul 30 10:44:12 PinePhone ofonod[2543]: src/radio-
settings.c:radio_load_settings() UmtsBand: 0
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/radio-
settings.c:qmi_set_rat_mode()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:qmi_sms_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:qmi_sms_probe() 
SMS AT CHAT REGISTER 2
Jul 30 10:44:12 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property ForceSimLegacy
Jul 30 10:44:12 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NumPremuxInterfaces
Jul 30 10:44:12 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property NetworkInterface
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/gprs-
context.c:qmi_gprs_context_probev()
Jul 30 10:44:12 PinePhone ofonod[2543]: plugins/
gobi.c:gobi_slot_set_sim_state() gobi_slot_set_sim_state
Jul 30 10:44:12 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property AlwaysOnline
Jul 30 10:44:12 PinePhone ofonod[2543]: src/modem.c:modem_change_state() old 
state: 2, new state: 3
Jul 30 10:44:12 PinePhone ofonod[2543]: plugins/gobi.c:gobi_post_online() 
0x10f6d260
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_netreg_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
netmon.c:qmi_netmon_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
ussd.c:qmi_ussd_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/call-
settings.c:qmi_call_settings_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/call-
barring.c:qmi_call_barring_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/call-
forwarding.c:qmi_call_forwarding_probe()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fca path len 0
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
lte.c:get_default_profile_cb()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
lte.c:get_default_profile_cb() Default profile index: 1
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:set_event_cb()
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:get_default_profile_number_cb() Default profile index: 1
Jul 30 10:44:12 PinePhone ofonod[2543]: drivers/qmimodem/radio-
settings.c:set_system_selection_pref_cb()
Jul 30 10:44:13 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:14 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:14 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:15 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:15 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:16 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:16 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:16 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:16 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:16 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:16 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:17 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:17 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:44:18 PinePhone voicecall-ui[3312]: [D] unknown:0 - (dial) GetAll() 
failed: "org.freedesktop.DBus.Error.UnknownObject" "Method \"GetAll\" with 
signature \"\" on interface \"org.sailfishos.ofono.mdm.VoiceCallFilter\" 
doesn't exist\n"
Jul 30 10:44:18 PinePhone voicecall-ui[3312]: [D] unknown:0 - (incoming) 
GetAll() failed: "org.freedesktop.DBus.Error.UnknownObject" "Method \"GetAll\" 
with signature \"\" on interface \"org.sailfishos.ofono.mdm.VoiceCallFilter\" 
doesn't exist\n"
Jul 30 10:44:40 PinePhone eg25-manager[2507]: Response: [OK\r\n\r\n+QIND: SMS 
DONE]
Jul 30 10:44:40 PinePhone eg25-manager[2507]: Initiate GNSS assistance data 
upload: "RAM:xtra2.bin",60850,10
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status unregistered (0)
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status registered (1)
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:qmi_set_attached() attached 0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status unregistered (0)
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status registered (1)
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:set_event_report_cb()
Jul 30 10:44:40 PinePhone eg25-manager[2507]: Executed soft wake sequence
Jul 30 10:44:40 PinePhone eg25-manager[2507]: Successfully sent command: 
AT+QFUPL="RAM:xtra2.bin",60850,10
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
found 6 routes
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 0 => type 1 value 3
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 1 => type 1 value 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 2 => type 0 value 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 3 => type 1 value 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 4 => type 1 value 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 5 => type 1 value 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_routes_cb() 
transfer status report 0
Jul 30 10:44:40 PinePhone eg25-manager[2507]: Response: 
[AT+QFUPL="RAM:xtra2.bin",60850,10\r\r\nCONNECT]
Jul 30 10:44:40 PinePhone eg25-manager[2507]: Modem ready for GNSS assistance 
data upload
Jul 30 10:44:40 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(4/7): uploading assistance data
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
lte.c:reset_profile_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
lte.c:qmimodem_lte_set_default_attach_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:set_event_report_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 0x0004
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:attach_detach_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:gprs_attach_callback() /
quectelqmi_0 error = 0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:qmi_attached_status()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_registration_status()
Jul 30 10:44:40 PinePhone ofonod[2543]: src/sim.c:ofono_sim_add_spn_watch() 
0x10f76330
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
sailfish_watch.c:ofono_watch_netreg_notify() quectelqmi_0 netreg registered
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:__ofono_netreg_add_status_watch() 0x10f65860
Jul 30 10:44:40 PinePhone ofonod[2543]: src/sim-info.c:sim_info_set_netreg() 
quectelqmi_0 netreg attached
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:__ofono_netreg_add_status_watch() 0x10f65860
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:set_routes_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:__ofono_netreg_add_status_watch() 0x10f65860
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:qmi_bearer_set() bearer 3
Jul 30 10:44:40 PinePhone ofonod[2543]: src/sms.c:sms_restore_tx_queue()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 0 mode 0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 2 mode 0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 0 mode 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 2 mode 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_protocol()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
lte.c:modify_profile_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:indication_register_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:__ofono_netreg_add_status_watch() 0x10f65860
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
sailfish_watch.c:ofono_watch_gprs_notify() quectelqmi_0 gprs registered
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:qmi_sca_query()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:get_ss_info_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:registration_status_cb() /
quectelqmi_0 error 0 status 1
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status registered (1)
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_ss_info_cb()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 8
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() i" (234:020)
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use: lte
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 0 lac 11016 cellid -1 tech 7
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 1 tech 7 lac 11016 
ci -1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_current_operator()
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:current_operator_callback() 0x10f65860, (nil)
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 1 
(registered)
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:gprs_netreg_update() 
attach: 1, driver_attached: 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_signal_strength()
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 1 
(registered)
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:gprs_netreg_update() 
attach: 1, driver_attached: 1
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_signal_strength()
Jul 30 10:44:40 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:set_domain_pref_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_protocol_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_protocol_cb() query both CDMA and WCDMA
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_msg_list()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:event_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:event_notify() signal with 40%(-81 dBm) on 8
Jul 30 10:44:41 PinePhone ofonod[2543]: src/
network.c:ofono_netreg_strength_notify() strength 40
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status registered (1)
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:ss_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 1
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 8
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use: lte
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech 7
Jul 30 10:44:41 PinePhone ofonod[2543]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 1 tech 7 lac 11016 
ci -1
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_current_operator()
Jul 30 10:44:41 PinePhone ofonod[2543]: src/
network.c:current_operator_callback() 0x10f65860, 0x10f4c440
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_signal_strength()
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 1 
(registered)
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:gprs_netreg_update() 
attach: 1, driver_attached: 1
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x001d
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1e len 0x0002
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x21 len 0x0001
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x24 len 0x0001
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x27 len 0x0001
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x2a len 0x0001
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x2b len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x32 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x35 len 0x0002
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x39 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3a len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3f len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x45 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x47 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status registered (1)
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb() signal with -81 dBm on 8
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb() signal with -81 dBm on 8
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_smsc_addr_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status unregistered (0)
Jul 30 10:44:41 PinePhone ofonod[2543]: src/
gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:ss_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 1
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 8
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use: lte
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech 7
Jul 30 10:44:41 PinePhone ofonod[2543]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 1 tech 7 lac 11016 
ci -1
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_current_operator()
Jul 30 10:44:41 PinePhone ofonod[2543]: src/
network.c:current_operator_callback() 0x10f65860, 0x10f4c440
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:qmi_signal_strength()
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 1 
(registered)
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:gprs_netreg_update() 
attach: 1, driver_attached: 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x001d
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1e len 0x0002
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x27 len 0x0001
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x32 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x35 len 0x0002
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3a len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3f len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x45 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x47 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x001d
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1e len 0x0002
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x27 len 0x0001
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x32 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x35 len 0x0002
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3a len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3f len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x45 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x47 len 0x0004
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_list_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_list_cb() Err: get msg list mode=0 47=UNKNOWN
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/sms.c:get_msg_list()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb() signal with -81 dBm on 8
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:get_rssi_cb() signal with -81 dBm on 8
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_list_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sms.c:get_msg_list_cb() msgs found 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fc9 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f11 path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: src/message-
waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fcb path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:41 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f46 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x4f20 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f15 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fc7 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f14 path len 0
Jul 30 10:44:42 PinePhone ofonod[2543]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Successfully uploaded 60850 
bytes to the modem
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Response: [+QFUPL: 
60850,6acf\r\n\r\nOK]
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:46 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(5/7): finishing upload
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Setting GNSS assistance UTC 
clock to: 0,"2024/07/30,09:44:46"
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Setting GNSS assistance file to: 
"RAM:xtra2.bin"
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Executed soft wake sequence
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Successfully sent command: 
AT+QGPSXTRATIME=0,"2024/07/30,09:44:46"
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Response: 
[AT+QGPSXTRATIME=0,"2024/07/30,09:44:46"\r\r\nOK]
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Successfully sent command: 
AT+QGPSXTRADATA="RAM:xtra2.bin"
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Response: 
[AT+QGPSXTRADATA="RAM:xtra2.bin"\r\r\nOK]
Jul 30 10:44:46 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:44:46 PinePhone eg25-manager[2507]: GNSS assistance data upload 
finished
Jul 30 10:44:46 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(6/7): re-enabling GNSS through AT+QGPS
Jul 30 10:44:46 PinePhone eg25-manager[2507]: GNSS assistance upload step 
(7/7): finished
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 0
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status unregistered (0)
Jul 30 10:44:57 PinePhone ofonod[2543]: src/
gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:ss_info_notify()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 0
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 0
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use:
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech -1
Jul 30 10:44:57 PinePhone ofonod[2543]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 0 tech -1 lac -1 
ci -1
Jul 30 10:44:57 PinePhone ofonod[2543]: src/
network.c:current_operator_callback() 0x10f65860, 0x10f4c440
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 0 
(unregistered)
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:gprs_netreg_update() 
attach: 0, driver_attached: 0
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 0 
(unregistered)
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:gprs_netreg_update() 
attach: 0, driver_attached: 0
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x16 len 0x0008
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:44:57 PinePhone ofonod[2543]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x16 len 0x0008
Jul 30 10:46:00 PinePhone eg25-manager[2507]: Modem is up for 120 seconds and 
fully ready
Jul 30 10:46:00 PinePhone eg25-manager[2507]: dropping systemd sleep block 
inhibitor
Jul 30 10:46:41 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:46:41 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath
Jul 30 10:46:41 PinePhone ofonod[2543]: src/modem.c:get_modem_property() modem 
0x10f6d260 property SystemPath



----

Second log after ofono restart

Jul 30 10:51:33 PinePhone ofonod[2543]: Exit
Jul 30 10:51:33 PinePhone connmand[2627]: [ofono] ERROR! Operation was 
cancelled
Jul 30 10:51:33 PinePhone connmand[2627]: [ofono] ERROR! Operation was 
cancelled
Jul 30 10:51:33 PinePhone connmand[2627]: [ofono] ERROR! Operation was 
cancelled
Jul 30 10:51:33 PinePhone eg25-manager[2507]: oFono vanished from D-Bus
Jul 30 10:51:33 PinePhone audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=ofono comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Jul 30 10:51:33 PinePhone kernel: audit: type=1131 audit(1722333093.671:120): 
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=ofono comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jul 30 10:51:33 PinePhone ofonod[3682]: oFono version 2.9
Jul 30 10:51:33 PinePhone kernel: audit: type=1130 audit(1722333093.771:121): 
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=ofono comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jul 30 10:51:33 PinePhone audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=ofono comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Jul 30 10:51:33 PinePhone ofonod[3682]: src/module.c:__ofono_modules_init()
Jul 30 10:51:33 PinePhone ofonod[3682]: src/manager.c:manager_init() 
manager_init
Jul 30 10:51:33 PinePhone ofonod[3682]: src/provision.c:provision_init()
Jul 30 10:51:33 PinePhone ofonod[3682]: src/slot-
manager.c:ofono_slot_manager_object_init() Default voice sim is (auto)
Jul 30 10:51:33 PinePhone ofonod[3682]: src/slot-
manager.c:ofono_slot_manager_object_init() Default data sim is (auto)
Jul 30 10:51:33 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_set_block() blocking ALL requests
Jul 30 10:51:33 PinePhone ofonod[3682]: src/plugin.c:__ofono_plugin_init()
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring Sailfish D-Bus access plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Excluding Phone Simulator driver
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring ST-Ericsson Modem Init Daemon 
detection
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring ConnMan plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Excluding External Hands-Free Profile 
Plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Excluding Dial-up Networking Profile 
Plugins
Jul 30 10:51:33 PinePhone ofonod[3682]: Excluding BlueZ 5 Utils Plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Excluding Hands-Free Audio Gateway 
Profile Plugins
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring Sailfish OS Bluetooth Plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring upower battery monitor
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring Smart Messaging Plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring Push Notification Plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring Push Forwarder Plugin
Jul 30 10:51:33 PinePhone ofonod[3682]: Ignoring Plugin to read EFACL from SIM
Jul 30 10:51:33 PinePhone ofonod[3682]: Can't load /usr/lib64/ofono/plugins/
amlplugin.so: /usr/lib64/ofono/plugins/amlplugin.so: undefined symbol: 
ofono_voicecall_is_emergency_number
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:udev_start()
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:enumerate_devices()
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1a000.usb/usb2
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1a400.usb/usb4
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
usb [1d6b:0002]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.0/ttyUSB0/
tty/ttyUSB0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() /dev/
ttyUSB0 (quectelqmi) 255/255/255 [00] ==> (null) (null)
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.1/ttyUSB1/
tty/ttyUSB1
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() /dev/
ttyUSB1 (quectelqmi) 255/0/0 [01] ==> (null) (null)
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.2/ttyUSB2/
tty/ttyUSB2
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.2/ttyUSB2/tty/ttyUSB2
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() /dev/
ttyUSB2 (quectelqmi) 255/0/0 [02] ==> (null) (null)
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.3/ttyUSB3/
tty/ttyUSB3
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.3/ttyUSB3/tty/ttyUSB3
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() /dev/
ttyUSB3 (quectelqmi) 255/0/0 [03] ==> (null) (null)
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.4/net/wwan0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
qmi_wwan [2c7c:0125]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.4/net/wwan0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() (null) 
(quectelqmi) 255/255/255 [04] ==> (null) (null)
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.4/usbmisc/
cdc-wdm0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
qmi_wwan [2c7c:0125]
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.4/usbmisc/cdc-wdm0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:add_device() /dev/
cdc-wdm0 (quectelqmi) 255/255/255 [04] ==> (null) (null)
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b400.usb/usb3
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:create_modem() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:create_modem() 
driver=quectelqmi
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:ofono_modem_create() name: 
(null), type: quectelqmi
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() /
sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB0 255/255/255 00 (null) tty
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB1 255/0/0 01 (null) tty
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB2 255/0/0 02 (null) tty
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB3 255/0/0 03 (null) tty
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() /
dev/cdc-wdm0 255/255/255 04 (null) usbmisc
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() 
(null) 255/255/255 04 (null) net
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_quectelqmi() 
gps=/dev/ttyUSB1 aux=/dev/ttyUSB2
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/udevng.c:setup_qmi_qmux() qmi: 
/dev/cdc-wdm0 net: wwan0 kernel_driver: qmi_wwan interface_number: 04
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:ofono_modem_set_driver() 
type: gobi
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property Device
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property InterfaceNumber
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property Bus
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property NetworkInterfaceKernelDriver
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property NetworkInterface
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property NetworkInterfaceIndex
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property GPS
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property Aux
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:set_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:ofono_modem_register() 
0x639d7f0
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/gobi.c:gobi_probe() 0x639d7f0
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterfaceKernelDriver
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterface
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterfaceIndex
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property Bus
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/gobi.c:gobi_probe() net: 
wwan0[qmi_wwan](4) usb
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterfaceIndex
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterface
Jul 30 10:51:33 PinePhone ofonod[3682]: src/
modem.c:ofono_modem_set_capabilities() 1
Jul 30 10:51:33 PinePhone ofonod[3682]: gobi_slot_plugin_start
Jul 30 10:51:33 PinePhone ofonod[3682]: src/slot-
manager.c:slot_manager_init_countdown_cb() done with registrations
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/gobi.c:gobi_slot_driver_init() 
gobi_slot_driver_init
Jul 30 10:51:33 PinePhone ofonod[3682]: plugins/
gobi.c:gobi_slot_driver_start() gobi_slot_driver_start
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:emit_modem_added() 
0x639d7f0
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:call_modemwatches() 
0x639d7f0 added:1
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x639d0d0
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:33 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639d050
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x6399650
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639ca70
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639ced0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639bd40
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639cf50
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639cd50
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639ccd0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639cdd0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x639cbd0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:gobi_enable() 0x639d7f0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property Device
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property Aux
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:gobi_enable() Have 
atmodem
Jul 30 10:51:34 PinePhone connmand[2627]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:discover_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb() 
Requesting: 3
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb() 
Requesting: 1
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb() 
Requesting: 5
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb() 
Requesting: 9
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb() 
Requesting: 11
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:request_service_cb() 
All services requested, proceeding to create WDA
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:create_wda_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_data_format_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterface
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:setup_qmi_wwan() 
raw_ip: Y, want: Y
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x63b6b10
Jul 30 10:51:34 PinePhone ofonod[3682]: Got IMEI 867698042994007
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/
gobi.c:gobi_slot_driver_startup_check() gobi_slot_driver_startup_check
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sailfish_watch.c:ofono_watch_new() 
quectelqmi_0 created
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim-info-
dbus.c:sim_info_dbus_new() /quectelqmi_0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/cell-info-
control.c:cell_info_control_get() /quectelqmi_0 created
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager.c:slot_add_internal() 
quectelqmi_0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x63d7ce0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x63d7cc0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x63bd0b0
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property SystemPath
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_caps_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_caps_cb() service 
capabilities 4
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_caps_cb() sim 
supported 2
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_caps_cb() radio = 4
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_caps_cb() radio = 5
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_caps_cb() radio = 8
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:get_oper_mode_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property AlwaysOnline
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:modem_change_state() old 
state: 0, new state: 1
Jul 30 10:51:34 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property ForceSimLegacy
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/gobi.c:gobi_pre_sim() 
0x639d7f0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:qmi_devinfo_probe()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_sim_probev()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
voicecall.c:qmi_voicecall_probe()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
voicecall.c:qmi_voicecall_probe() VOICE AT CHAT REGISTER 1
Jul 30 10:51:34 PinePhone ofonod[3682]: plugins/
gobi.c:gobi_slot_set_sim_state() gobi_slot_set_sim_state
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-
manager.c:slot_manager_update_ready() ready
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_set_block() unblocking ALL requests
Jul 30 10:51:34 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_signal_boolean() ReadyChanged 1
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:get_caps_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:qmi_query_manufacturer()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:event_registration_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:event_registration_cb() event mask 0x0003
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/devinfo.c:string_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:qmi_query_model()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_card_status_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_state_watch() 
0x63bbf60
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_state_watch() 
0x63bbf60
Jul 30 10:51:34 PinePhone ofonod[3682]: src/
sailfish_watch.c:ofono_watch_sim_notify() quectelqmi_0 sim registered
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_state_watch() 
0x63bbf60
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_iccid_watch() 
0x63bbf60
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_imsi_watch() 
0x63bbf60
Jul 30 10:51:34 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_state_watch() 
0x63bbf60
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fb7 path len 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/devinfo.c:string_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:qmi_query_revision()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: Requested file structure differs from 
SIM: 6fb7
Jul 30 10:51:34 PinePhone ofonod[3682]: src/voicecall.c:ecc_g2_read_cb() 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fb7 path len 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/devinfo.c:string_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:qmi_query_serial()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
devinfo.c:get_ids_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:34 PinePhone ofonod[3682]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:51:34 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/voicecall.c:ecc_g3_read_cb() 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x2fe2 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x2fe2 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 10
Jul 30 10:51:35 PinePhone ofonod[3682]: src/sim-
info.c:sim_info_iccid_watch_cb() quectelqmi_0 8944200122784036312
Jul 30 10:51:35 PinePhone ofonod[3682]: src/sim-info.c:sim_info_load_cache() 
quectelqmi_0 imsi[8944200122784036312] = 234206313731703
Jul 30 10:51:35 PinePhone ofonod[3682]: src/sim-info.c:sim_info_load_cache() 
quectelqmi_0 no spn for imsi 234206313731703
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f05 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f05 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 10
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x2f05 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x2f05 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 10
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_query_passwd_state()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:query_passwd_state_cb() passwd state 0
Jul 30 10:51:35 PinePhone ofonod[3682]: src/sim.c:sim_pin_query_cb() sim-
>pin_type: 0, pin_type: 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_query_pin_retries()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fae path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fad path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:query_pin_retries_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6fad path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 4
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f16 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f38 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f38 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 12
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f56 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f56 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/simfs.c:sim_fs_op_read_block_cb() 
bufoff: 0, dataoff: 0, tocopy: 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sim.c:qmi_read_imsi()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sim.c:get_imsi_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_transparent() file id 0x6f07 path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_spn_watch() 
0x63bbf60
Jul 30 10:51:35 PinePhone ofonod[3682]: src/slot-
manager.c:slot_manager_update_modem_paths() Default voice SIM at /quectelqmi_0
Jul 30 10:51:35 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_signal_string() DefaultVoiceModemChanged /
quectelqmi_0
Jul 30 10:51:35 PinePhone ofonod[3682]: src/modem.c:modem_change_state() old 
state: 1, new state: 2
Jul 30 10:51:35 PinePhone ofonod[3682]: plugins/gobi.c:gobi_post_sim() 
0x639d7f0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
lte.c:qmimodem_lte_probe()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/radio-
settings.c:qmi_radio_settings_probev()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/radio-
settings.c:radio_load_settings() TechnologyPreference: 4
Jul 30 10:51:35 PinePhone ofonod[3682]: src/radio-
settings.c:radio_load_settings() GsmBand: 0
Jul 30 10:51:35 PinePhone ofonod[3682]: src/radio-
settings.c:radio_load_settings() UmtsBand: 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/radio-
settings.c:qmi_set_rat_mode()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:qmi_sms_probe()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:qmi_sms_probe() 
SMS AT CHAT REGISTER 2
Jul 30 10:51:35 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property ForceSimLegacy
Jul 30 10:51:35 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NumPremuxInterfaces
Jul 30 10:51:35 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property NetworkInterface
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:qmi_gprs_context_probev()
Jul 30 10:51:35 PinePhone ofonod[3682]: plugins/
gobi.c:gobi_slot_set_sim_state() gobi_slot_set_sim_state
Jul 30 10:51:35 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property AlwaysOnline
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fca path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
lte.c:get_default_profile_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
lte.c:get_default_profile_cb() Default profile index: 1
Jul 30 10:51:35 PinePhone voicecall-ui[3312]: [D] unknown:0 - (dial) GetAll() 
failed: "org.freedesktop.DBus.Error.UnknownObject" "Method \"GetAll\" with 
signature \"\" on interface \"org.sailfishos.ofono.mdm.VoiceCallFilter\" 
doesn't exist\n"
Jul 30 10:51:35 PinePhone voicecall-ui[3312]: [D] unknown:0 - (incoming) 
GetAll() failed: "org.freedesktop.DBus.Error.UnknownObject" "Method \"GetAll\" 
with signature \"\" on interface \"org.sailfishos.ofono.mdm.VoiceCallFilter\" 
doesn't exist\n"
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/radio-
settings.c:set_system_selection_pref_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:set_event_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:get_default_profile_number_cb() Default profile index: 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
lte.c:reset_profile_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
lte.c:qmimodem_lte_set_default_attach_info()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
found 6 routes
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 0 => type 1 value 3
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 1 => type 1 value 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 2 => type 0 value 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 3 => type 1 value 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 4 => type 1 value 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
type 0 class 5 => type 1 value 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_routes_cb() 
transfer status report 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:set_event_report_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 0x0004
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
lte.c:modify_profile_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:set_routes_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:qmi_bearer_set() bearer 3
Jul 30 10:51:35 PinePhone ofonod[3682]: src/sms.c:sms_restore_tx_queue()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 0 mode 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 2 mode 0
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 0 mode 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:delete_msg() 
delete msg tag 2 mode 1
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_protocol()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:qmi_sca_query()
Jul 30 10:51:35 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:indication_register_cb()
Jul 30 10:51:35 PinePhone ofonod[3682]: src/
sailfish_watch.c:ofono_watch_gprs_notify() quectelqmi_0 gprs registered
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:set_domain_pref_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_protocol_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_protocol_cb() query both CDMA and WCDMA
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_msg_list()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_smsc_addr_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status unregistered (0)
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_list_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_list_cb() Err: get msg list mode=0 47=UNKNOWN
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/sms.c:get_msg_list()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fca path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_list_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sms.c:get_msg_list_cb() msgs found 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fc9 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc9 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f11 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/modem.c:get_modem_property() modem 
0x639d7f0 property AlwaysOnline
Jul 30 10:51:36 PinePhone ofonod[3682]: plugins/gobi.c:gobi_set_online() 
0x639d7f0 online using_mux: no
Jul 30 10:51:36 PinePhone ofonod[3682]: plugins/gobi.c:powered_up_cb() error: 
0
Jul 30 10:51:36 PinePhone ofonod[3682]: plugins/gobi.c:set_online_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: src/slot-
manager.c:slot_manager_update_modem_paths() Default data SIM at /quectelqmi_0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/slot-manager-
dbus.c:slot_manager_dbus_signal_string() DefaultDataModemChanged /quectelqmi_0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/modem.c:modem_change_state() old 
state: 2, new state: 3
Jul 30 10:51:36 PinePhone ofonod[3682]: plugins/gobi.c:gobi_post_online() 
0x639d7f0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:qmi_netreg_probe()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
netmon.c:qmi_netmon_probe()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
ussd.c:qmi_ussd_probe()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/call-
settings.c:qmi_call_settings_probe()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/call-
barring.c:qmi_call_barring_probe()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/call-
forwarding.c:qmi_call_forwarding_probe()
Jul 30 10:51:36 PinePhone eg25-manager[2507]: Response: [+QIND: SMS DONE]
Jul 30 10:51:36 PinePhone eg25-manager[2507]: Executed soft sleep sequence
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: src/message-
waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f40 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:set_event_report_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:qmi_registration_status()
Jul 30 10:51:36 PinePhone ofonod[3682]: src/sim.c:ofono_sim_add_spn_watch() 
0x63bbf60
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
network.c:__ofono_netreg_add_status_watch() 0x63bb3f0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
network.c:__ofono_netreg_add_status_watch() 0x63bb3f0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
sailfish_watch.c:ofono_watch_netreg_notify() quectelqmi_0 netreg registered
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
network.c:__ofono_netreg_add_status_watch() 0x63bb3f0
Jul 30 10:51:36 PinePhone ofonod[3682]: src/sim-info.c:sim_info_set_netreg() 
quectelqmi_0 netreg attached
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
network.c:__ofono_netreg_add_status_watch() 0x63bb3f0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:get_ss_info_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 2
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use:
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech -1
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 2 tech -1 lac -1 
ci -1
Jul 30 10:51:36 PinePhone ofonod[3682]: src/
network.c:current_operator_callback() 0x63bb3f0, (nil)
Jul 30 10:51:36 PinePhone ofonod[3682]: src/gprs.c:netreg_status_changed() 2 
(searching)
Jul 30 10:51:36 PinePhone ofonod[3682]: src/gprs.c:gprs_netreg_update() 
attach: 0, driver_attached: 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:36 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6f40 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f46 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x4f20 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status unregistered (0)
Jul 30 10:51:37 PinePhone ofonod[3682]: src/
gprs.c:ofono_gprs_detached_notify() /quectelqmi_0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:ss_info_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 2
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 8
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() i" (234:020)
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use:
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech 7
Jul 30 10:51:37 PinePhone ofonod[3682]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 2 tech 7 lac -1 ci 
-1
Jul 30 10:51:37 PinePhone ofonod[3682]: src/
network.c:current_operator_callback() 0x63bb3f0, (nil)
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:netreg_status_changed() 2 
(searching)
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:gprs_netreg_update() 
attach: 0, driver_attached: 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x001d
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1e len 0x0002
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x27 len 0x0001
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x32 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x35 len 0x0002
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3a len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3f len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x45 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x47 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:event_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:event_notify() rat 8 band 145 channel 6175
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x16 len 0x0008
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x16 len 0x0008
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fc7 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fc7 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6fcb path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_record() file id 0x6fcb path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:read_generic_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f15 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:ss_info_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:handle_ss_info()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:extract_ss_info()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:extract_ss_info() radio in use 8
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:ofono_gprs_status_notify() 
/quectelqmi_0 status registered (1)
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:ss_info_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() serving system status 1
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio in use 8
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() i" (234:020)
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() radio techs in use: lte
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:extract_ss_info() roaming 0 lac 65534 cellid 3091208 tech 7
Jul 30 10:51:37 PinePhone ofonod[3682]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 1 tech 7 lac 65534 
ci 3091208
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:qmi_current_operator()
Jul 30 10:51:37 PinePhone ofonod[3682]: src/
network.c:current_operator_callback() 0x63bb3f0, (nil)
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:netreg_status_changed() 1 
(registered)
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:gprs_netreg_update() 
attach: 1, driver_attached: 1
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:qmi_signal_strength()
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:netreg_status_changed() 1 
(registered)
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:gprs_netreg_update() 
attach: 1, driver_attached: 1
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x001d
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1e len 0x0002
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x21 len 0x0001
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x27 len 0x0001
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x2a len 0x0001
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x2b len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x32 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x35 len 0x0002
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x39 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3a len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3f len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x45 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x47 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:event_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:event_notify() rat 8 band 145 channel 6175
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:get_rssi_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:get_rssi_cb() signal with -125 dBm on 8
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:get_lte_attach_params()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x20 len 0x0004
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:qmi_read_attributes() file id 0x6f14 path len 0
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:get_lte_attach_param_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: src/gprs.c:ofono_gprs_cid_activated() 
cid 1
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:qmi_gprs_read_settings() cid 1
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/
sim.c:get_file_attributes_cb()
Jul 30 10:51:37 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_lte_attach_param_cb()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:start_net_cb()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:start_net_cb() packet handle -2026143024
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:pkt_status_notify()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:pkt_status_notify() conn status 2
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:pkt_status_notify() ip family 4
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1d len 0x0009
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 0x0001
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_cb()
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_cb() PDP type 0
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_ipv4() IP addr: 100.64.84.72
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_ipv4() Gateway: 100.64.84.73
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_ipv4() Gateway netmask: 255.255.255.240
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_ipv4() Primary DNS: 188.31.250.128
Jul 30 10:51:38 PinePhone ofonod[3682]: drivers/qmimodem/gprs-
context.c:get_settings_ipv4() Secondary DNS: 188.31.250.129
Jul 30 10:51:38 PinePhone ofonod[3682]: src/
gprs.c:pri_read_settings_callback() 0x63ce000
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:system_info_notify()
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0003
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0003
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0003
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x001d
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1e len 0x0002
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x21 len 0x0001
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x27 len 0x0001
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x28 len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x2a len 0x0001
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x2b len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x30 len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x32 len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x35 len 0x0002
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x39 len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3a len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x3f len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x45 len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x47 len 0x0004
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:event_notify()
Jul 30 10:51:39 PinePhone ofonod[3682]: drivers/qmimodem/network-
registration.c:event_notify() signal with 40%(-81 dBm) on 8
Jul 30 10:51:39 PinePhone ofonod[3682]: src/
network.c:ofono_netreg_strength_notify() strength 40
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x10 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x11 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x12 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x13 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x14 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x15 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x19 len 0x0008
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x1a len 0x0008
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x25 len 0x0004
Jul 30 10:51:40 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x26 len 0x0004
Jul 30 10:51:51 PinePhone ofonod[3682]: drivers/qmimodem/
gprs.c:event_report_notify()
Jul 30 10:51:51 PinePhone ofonod[3682]: drivers/qmimodem/
qmi.c:qmi_result_print_tlvs() tlv: 0x18 len 0x0001
[root@PinePhone defaultuser]# 




