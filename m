Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFA84D02
	for <ofono@lists.linux.dev>; Mon, 29 Jul 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283619; cv=none; b=vCtZzKy0eZUV4tn926twlSMdakjjz68HChw3F9DQIdh6/Z7ciITKXwbSHmdIRTCMrPYyaJ7JRSeUZgbca9hXyxUii2Zk8AOTl6s2QidecpB3vvNzVRkz+zc9c1QRU5YWOSopQ5AD6wyJ1e7gWN/k+5yG3LA+JPaMNxFd0GhFvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283619; c=relaxed/simple;
	bh=tzP8aQs+xQuSfjhtzngvwwPTVu3uzXK2UFfI73ivrfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia9RVZThPV5ibdXgCUapKL/EM3TJyjJ4uh09xbY7jxLAj36VmF9iGmmagbFH1nu+5CVD7fAa6yPv0rCLjbksO45eRYUlRlCyc/awDIumoPnYQa1oAH2Kh60HQ3ffa8mfyEoH27GsHvntznjx9y9tYuzq3Nwu4knjgxw2bQSBk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBJaLzAD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBJaLzAD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso18579335e9.1
        for <ofono@lists.linux.dev>; Mon, 29 Jul 2024 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722283614; x=1722888414; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE1EPavi/gawc/qmPa8brJJOL8Riag6sUjEGd4srMnY=;
        b=EBJaLzADD8Q4hyef0wrOslQwF9AGsUpQUUSMSbFbJluNAYwQh9ARygAoZhhhRLh+Ux
         NuiRibZjGlUNeDOMP2ioYupA+qcAjF3rPvqrzQ3tmrTo8gjrQH+rXz+g+RcJ2k9+JQDO
         c+BBI4BRXmnzlOKxY3jRzi3sJGzac95RM9uR2p6I/Sr9RTL3LTe3YlORBJlys/eIa2BG
         C7A1Z0cSEwgsYnh+4Hdn7x9fx4kVBbPREXnYhdIrm+66+xapOrqei07Y8t+UmeUtiqa0
         wjB1NcWbHVurHZ8InePImvPPTY2F36sESmZdQmWqz/nK5q/1zztNyliyPpMbbk7NeE6c
         vXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283614; x=1722888414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE1EPavi/gawc/qmPa8brJJOL8Riag6sUjEGd4srMnY=;
        b=txcXc/lNNTVkR1TfB/2KjlHWAiC7WVcyEtNkXjhmJhA/fkVRpV/Ip8A1AxPKQbvB9W
         edrtMy2XyPO44eOL4B+BsHTAu35aqwyzWVQzrWYA15/1fXJDpeaCyGVeP4MgXJCP1pOX
         rhdwt2bY2Euf26yRnZ+TTQtB0kUylgjsThKkDkUqEgXSTaqs8PQ+mW0lLEwqLIdnacFp
         L6qzyqyMJb6XFeRyw9ry6usohI3TZFyNylGS8le9+mzyEggwWO0BN+sHx5gmo3VeTzZ4
         lzM3fSTPGMgipSmodciOOrPlFSFgCkob0kw3KmIXQk/2NEFrnzLseY7ILd1HGGbGee9w
         Hp0A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ265VigxGqibHpV36vrndUFPn/COWVvGZBp2VWR777xQ5CZRN1JEg8a4DNFA2hDKQcVXtdO9dQqg7Zm9hYDZeDK2TE3Q=
X-Gm-Message-State: AOJu0YyCWQNXODJgylF4HxlLSrun6qX49G37N4yLLwRf8S6Fyptjyij/
	Xd0XCX+u7MKUO+cl1sTWUveiK/K2SnrjAfgB4iCTij1FOvSn4bc0D9V5BoW5
X-Google-Smtp-Source: AGHT+IHSJN53Z7tYilhQqa3/GC5UHMC9IOMTRhtiEQNOfCgi/+3a0RLL68cvW73nO5RruYxnPba73Q==
X-Received: by 2002:a05:600c:1392:b0:426:5d37:67f0 with SMTP id 5b1f17b1804b1-42811d8cc95mr61634705e9.13.1722283612859;
        Mon, 29 Jul 2024 13:06:52 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.116.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d37bb88sm132473825e9.38.2024.07.29.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:06:52 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Subject: Re: Idle Loop
Date: Mon, 29 Jul 2024 21:06:49 +0100
Message-ID: <2131096.YKUYFuaPT4@adam-laptop-hp>
In-Reply-To: <1f7fc554-43a1-49f3-aa3e-f2b51bafeb5a@gmail.com>
References:
 <4939268.OV4Wx5bFTl@adam-laptop-hp>
 <1f7fc554-43a1-49f3-aa3e-f2b51bafeb5a@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday 27 July 2024 16:58:09 BST you wrote:
> Hi Adam,
> 
> On 7/26/24 12:03 PM, Adam Pigg wrote:
> > Hi Dennis
> > 
> > Wondered if I could pick your brain about a new issue I have.
> > 
> > In the patches I apply ontop of stock Ofono for Sailfish, there is a
> > plugin
> > called the Slot Manager.
> > 
> > On 2.7 all is fine.
> > 
> > On 2.9 not so.
> > 
> > The code in the slot manager, after its creation waits for 5 iterations of
> > the event loop before disallowing any more drivers to register, and it
> > seems that in 2.9, this is much more likely to happen, though its a bit
> > inconsistent.
> Why would it be doing that?

Basically, it allows 5 iterations for a driver to register, then, after 5, it 
does its own initialization.

Ive hacked in a change to this to allow any time for a driver to register, 
then perform the init after that, and it kinda works......

However, ive now hit a different 2.9 issue.

On boot, ofono is started via the system service.  Looking at the log output, 
at the disocver_cb stage, instead of creating all the services, it instead 
goes to the shutdown stage.  If I restart ofono after this is works fine.  Ive 
attached the failing log to the end of this email.

I also included the output of eg25-manager, I suspect the issue is around the 
initialisation eg25-manager is doing, though i dont know why this doesnt 
happen in 2.7

Any thoughts, welcome, currently im wondering if I can work around it by 
delaying ofono startup until after the modem is properly init'ed.

> 
> > I wondered if it could be related to
> > https://git.kernel.org/pub/scm/network/
> > ofono/ofono.git/commit/?id=063856a2ba9308e1776a3f906bd2ed9a9f760744 and
> > what a correct solution might look like (I understand this is my issue as
> > the code isnt upstream!)
> 
> This commit makes drivers register on probe such that no main loop
> iterations are needed between probe() and register().
> 
> I assume we are talking about atom drivers here (everything in drivers/*). 
> Atom drivers when probed (probe() is invoked) start their initialization
> process. This process can take as much time as these drivers need.  Putting
> a cap of the number of iterations doesn't make any sense.
> 
> > Potentially the check for 5 iterations of the loop isnt even necessary
> > (and
> > seems very arbitrary!) so Ill test without it.
> > 
> > Is there a reason that the gobi plugin/qmimodem driver combination now
> > takes an indeterminate amount of event loop time to appear?
> 
> See above.  gobi / qmimodem now perform more steps after probe() and before
> register().
> 
> > Any thoughts welcome,
> > Kind Regards
> > 
> > Adam
> 
> Regards,
> -Denis

Thanks

Adam

---

[root@PinePhone defaultuser]# journalctl -b | grep -i "ofono\|eg25"
Jul 29 20:35:00 PinePhone systemd[1]: Started Quectel EG25 modem.
Jul 29 20:35:00 PinePhone audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=eg25-manager comm="systemd" exe="/usr/lib/systemd/
systemd" hostname=? addr=? terminal=? res=success'
Jul 29 20:35:00 PinePhone eg25-manager[2572]: Opening config file: /usr/share/
eg25-manager/pine64,pinephone-1.2.toml
Jul 29 20:35:00 PinePhone eg25-manager[2572]: Starting modem...
Jul 29 20:35:00 PinePhone ofonod[2595]: oFono version 2.9
Jul 29 20:35:00 PinePhone audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=ofono comm="systemd" exe="/usr/lib/systemd/systemd" 
hostname=? addr=? terminal=? res=success'
Jul 29 20:35:00 PinePhone ofonod[2595]: src/module.c:__ofono_modules_init()
Jul 29 20:35:00 PinePhone ofonod[2595]: src/manager.c:manager_init() 
manager_init
Jul 29 20:35:00 PinePhone ofonod[2595]: src/provision.c:provision_init()
Jul 29 20:35:01 PinePhone ofonod[2595]: src/slot-
manager.c:ofono_slot_manager_object_init() Default voice sim is (auto)
Jul 29 20:35:01 PinePhone ofonod[2595]: src/slot-
manager.c:ofono_slot_manager_object_init() Default data sim is (auto)
Jul 29 20:35:01 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_set_block() blocking ALL requests
Jul 29 20:35:01 PinePhone ofonod[2595]: src/plugin.c:__ofono_plugin_init()
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring Sailfish D-Bus access plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Excluding Phone Simulator driver
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring ST-Ericsson Modem Init Daemon 
detection
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring ConnMan plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Excluding External Hands-Free Profile 
Plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Excluding Dial-up Networking Profile 
Plugins
Jul 29 20:35:01 PinePhone ofonod[2595]: Excluding BlueZ 5 Utils Plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Excluding Hands-Free Audio Gateway 
Profile Plugins
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring Sailfish OS Bluetooth Plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring upower battery monitor
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring Smart Messaging Plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring Push Notification Plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring Push Forwarder Plugin
Jul 29 20:35:01 PinePhone ofonod[2595]: Ignoring Plugin to read EFACL from SIM
Jul 29 20:35:01 PinePhone ofonod[2595]: Can't load /usr/lib64/ofono/plugins/
amlplugin.so: /usr/lib64/ofono/plugins/amlplugin.so: undefined symbol: 
ofono_voicecall_is_emergency_number
Jul 29 20:35:01 PinePhone ofonod[2595]: plugins/udevng.c:udev_start()
Jul 29 20:35:01 PinePhone ofonod[2595]: plugins/udevng.c:enumerate_devices()
Jul 29 20:35:01 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1a000.usb/usb3
Jul 29 20:35:01 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1a400.usb/usb4
Jul 29 20:35:01 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1
Jul 29 20:35:01 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b400.usb/usb2
Jul 29 20:35:01 PinePhone eg25-manager[2572]: Executed power-on/off sequence
Jul 29 20:35:01 PinePhone eg25-manager[2572]: taking systemd sleep inhibitor
Jul 29 20:35:01 PinePhone eg25-manager[2572]: oFono appeared on D-Bus
Jul 29 20:35:02 PinePhone eg25-manager[2572]: inhibitor sleep fd is 19
Jul 29 20:35:02 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 29 20:35:02 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
usb [1d6b:0002]
Jul 29 20:35:03 PinePhone ofonod[2595]: plugins/udevng.c:check_modem_list()
Jul 29 20:35:05 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16ac4d40
Jul 29 20:35:07 PinePhone ofonod[2595]: plugins/udevng.c:remove_device() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.0
Jul 29 20:35:07 PinePhone ofonod[2595]: plugins/udevng.c:remove_device() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 29 20:35:13 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afe6b0
Jul 29 20:35:21 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ac4140
Jul 29 20:35:21 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af02c0
Jul 29 20:35:22 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 29 20:35:22 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
usb [1d6b:0002]
Jul 29 20:35:23 PinePhone eg25-manager[2572]: Response: [RDY]
Jul 29 20:35:23 PinePhone eg25-manager[2572]: taking systemd sleep inhibitor 
(blocking)
Jul 29 20:35:23 PinePhone eg25-manager[2572]: inhibitor block fd is 21
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.4/usbmisc/
cdc-wdm0
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
qmi_wwan [2c7c:0125]
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.4/usbmisc/cdc-wdm0
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() /dev/
cdc-wdm0 (quectelqmi) 255/255/255 [04] ==> (null) (null)
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.3/ttyUSB3/
tty/ttyUSB3
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.3/ttyUSB3/tty/ttyUSB3
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() /dev/
ttyUSB3 (quectelqmi) 255/0/0 [03] ==> (null) (null)
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.2/ttyUSB2/
tty/ttyUSB2
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.2/ttyUSB2/tty/ttyUSB2
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() /dev/
ttyUSB2 (quectelqmi) 255/0/0 [02] ==> (null) (null)
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.1/ttyUSB1/
tty/ttyUSB1
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() /dev/
ttyUSB1 (quectelqmi) 255/0/0 [01] ==> (null) (null)
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.0/ttyUSB0/
tty/ttyUSB0
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
option [2c7c:0125]
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() /dev/
ttyUSB0 (quectelqmi) 255/255/255 [00] ==> (null) (null)
Jul 29 20:35:23 PinePhone eg25-manager[2572]: Response: [+CFUN: 1]
Jul 29 20:35:23 PinePhone eg25-manager[2572]: Executed soft sleep sequence
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
devsyspath: /sys/devices/platform/soc/1c1b000.usb/usb1/1-1/1-1:1.4/net/wwan0
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:check_usb_device() 
qmi_wwan [2c7c:0125]
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() modem:/
sys/devices/platform/soc/1c1b000.usb/usb1/1-1 device:/sys/devices/platform/
soc/1c1b000.usb/usb1/1-1/1-1:1.4/net/wwan0
Jul 29 20:35:23 PinePhone ofonod[2595]: plugins/udevng.c:add_device() (null) 
(quectelqmi) 255/255/255 [04] ==> (null) (null)
Jul 29 20:35:23 PinePhone eg25-manager[2572]: Response: [+CPIN: 
READY\r\n\r\n+QUSIM: 1]
Jul 29 20:35:23 PinePhone eg25-manager[2572]: Executed soft sleep sequence
Jul 29 20:35:24 PinePhone eg25-manager[2572]: Response: [+QIND: SMS DONE]
Jul 29 20:35:24 PinePhone eg25-manager[2572]: Executed soft sleep sequence
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:check_modem_list()
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:create_modem() /sys/
devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:create_modem() 
driver=quectelqmi
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:ofono_modem_create() name: 
(null), type: quectelqmi
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() /
sys/devices/platform/soc/1c1b000.usb/usb1/1-1
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB0 255/255/255 00 (null) tty
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB1 255/0/0 01 (null) tty
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB2 255/0/0 02 (null) tty
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() /
dev/ttyUSB3 255/0/0 03 (null) tty
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() 
(null) 255/255/255 04 (null) net
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() /
dev/cdc-wdm0 255/255/255 04 (null) usbmisc
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_quectelqmi() 
gps=/dev/ttyUSB1 aux=/dev/ttyUSB2
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/udevng.c:setup_qmi_qmux() qmi: 
/dev/cdc-wdm0 net: wwan0 kernel_driver: qmi_wwan interface_number: 04
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:ofono_modem_set_driver() 
type: gobi
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property Device
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property InterfaceNumber
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property Bus
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property NetworkInterfaceKernelDriver
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property NetworkInterface
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property NetworkInterfaceIndex
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property GPS
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property Aux
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:set_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:ofono_modem_register() 
0x16b01990
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/gobi.c:gobi_probe() 0x16b01990
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property NetworkInterfaceKernelDriver
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property NetworkInterface
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property NetworkInterfaceIndex
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property Bus
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/gobi.c:gobi_probe() net: 
wwan0[qmi_wwan](4) usb
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property NetworkInterfaceIndex
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property NetworkInterface
Jul 29 20:35:24 PinePhone ofonod[2595]: src/
modem.c:ofono_modem_set_capabilities() 1
Jul 29 20:35:24 PinePhone ofonod[2595]: gobi_slot_plugin_start
Jul 29 20:35:24 PinePhone ofonod[2595]: src/slot-
manager.c:slot_manager_init_countdown_cb() done with registrations
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/gobi.c:gobi_slot_driver_init() 
gobi_slot_driver_init
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/
gobi.c:gobi_slot_driver_start() gobi_slot_driver_start
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:emit_modem_added() 
0x16b01990
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:call_modemwatches() 
0x16b01990 added:1
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/gobi.c:gobi_enable() 
0x16b01990
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property Device
Jul 29 20:35:24 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property Aux
Jul 29 20:35:24 PinePhone ofonod[2595]: plugins/gobi.c:gobi_enable() Have 
atmodem
Jul 29 20:35:25 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:25 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:26 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:26 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:26 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:26 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afe020
Jul 29 20:35:26 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:26 PinePhone eg25-manager[2572]: Response: [+QIND: PB DONE]
Jul 29 20:35:26 PinePhone eg25-manager[2572]: Executed soft sleep sequence
Jul 29 20:35:28 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:28 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:29 PinePhone ofonod[2595]: plugins/gobi.c:discover_cb()
Jul 29 20:35:29 PinePhone ofonod[2595]: plugins/gobi.c:shutdown_device() 
0x16b01990
Jul 29 20:35:29 PinePhone ofonod[2595]: plugins/gobi.c:shutdown_cb()
Jul 29 20:35:30 PinePhone connmand[2657]: [ofonoext] ERROR! Timeout was 
reached
Jul 29 20:35:30 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.Failed: Operation failed
Jul 29 20:35:30 PinePhone eg25-manager[2572]: GNSS assistance upload 
started...
Jul 29 20:35:30 PinePhone eg25-manager[2572]: GNSS assistance upload step 
(1/7): fetching assistance data
Jul 29 20:35:31 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Fetching GNSS assistance data 
from https://xtrapath4.izatcloud.net/xtra2.bin was successful
Jul 29 20:35:31 PinePhone eg25-manager[2572]: GNSS assistance upload step 
(2/7): disabling GNSS engine through AT+QGPS
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Executed soft wake sequence
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Successfully sent command: 
AT+QGPS?
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Response: [AT+QGPS?\r\r\n+QGPS: 
0\r\n\r\nOK]
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Executed soft sleep sequence
Jul 29 20:35:31 PinePhone eg25-manager[2572]: GNSS assistance upload step 
(3/7): initiating upload
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Executed soft wake sequence
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Successfully sent command: 
AT+QFDEL="RAM:*"
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Response: [AT+QFDEL="RAM:*"]
Jul 29 20:35:31 PinePhone eg25-manager[2572]: Executed soft sleep sequence
Jul 29 20:35:32 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16af8ab0
Jul 29 20:35:32 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:34 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afe4b0
Jul 29 20:35:34 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:35 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:35 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:35 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af8550
Jul 29 20:35:36 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:36 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:37 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:37 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:38 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:38 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:38 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:38 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:38 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afd220
Jul 29 20:35:38 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afd240
Jul 29 20:35:38 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af8ad0
Jul 29 20:35:38 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afd3c0
Jul 29 20:35:38 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:39 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afd880
Jul 29 20:35:40 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:40 PinePhone ofonod[2595]: src/modem.c:get_modem_property() modem 
0x16b01990 property SystemPath
Jul 29 20:35:40 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afde70
Jul 29 20:35:40 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afd540
Jul 29 20:35:40 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afb550
Jul 29 20:35:40 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:42 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:44 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:46 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:46 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afb8b0
Jul 29 20:35:46 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af4a40
Jul 29 20:35:48 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:50 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:35:51 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afbb80
Jul 29 20:35:52 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:24 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:26 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:27 PinePhone connmand[2657]: [ofonoext] ERROR! Timeout was 
reached
Jul 29 20:36:28 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:29 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16afd640
Jul 29 20:36:29 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afbef0
Jul 29 20:36:30 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:30 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afc060
Jul 29 20:36:32 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:33 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afc250
Jul 29 20:36:33 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afbfd0
Jul 29 20:36:33 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16afbff0
Jul 29 20:36:33 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af1310
Jul 29 20:36:34 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:34 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af1600
Jul 29 20:36:35 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af1860
Jul 29 20:36:35 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af1570
Jul 29 20:36:35 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af1b00
Jul 29 20:36:36 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:38 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:40 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:41 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af20f0
Jul 29 20:36:41 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af2110
Jul 29 20:36:42 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:44 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:46 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:47 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af2530
Jul 29 20:36:48 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:50 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:52 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:54 PinePhone connmand[2657]: [ofonoext] ERROR! Timeout was 
reached
Jul 29 20:36:54 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:54 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af25d0
Jul 29 20:36:55 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af27c0
Jul 29 20:36:56 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16af2a50
Jul 29 20:36:56 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:58 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae63f0
Jul 29 20:36:58 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:36:58 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae65e0
Jul 29 20:36:58 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af29c0
Jul 29 20:36:58 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae6880
Jul 29 20:36:59 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae6a00
Jul 29 20:37:00 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:00 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16af29e0
Jul 29 20:37:00 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae75b0
Jul 29 20:37:00 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae6ca0
Jul 29 20:37:02 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:04 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:06 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae7c00
Jul 29 20:37:06 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16b02d60
Jul 29 20:37:06 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:08 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:10 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:12 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:12 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8090
Jul 29 20:37:14 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:16 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:18 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:19 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8130
Jul 29 20:37:20 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:20 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8340
Jul 29 20:37:21 PinePhone connmand[2657]: [ofonoext] ERROR! Timeout was 
reached
Jul 29 20:37:22 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:23 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16ae8550
Jul 29 20:37:23 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8740
Jul 29 20:37:23 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae7950
Jul 29 20:37:23 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae89e0
Jul 29 20:37:23 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8b60
Jul 29 20:37:24 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:24 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8e70
Jul 29 20:37:25 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae90c0
Jul 29 20:37:25 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae7990
Jul 29 20:37:25 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9360
Jul 29 20:37:26 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:28 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:30 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:31 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9890
Jul 29 20:37:31 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae8320
Jul 29 20:37:32 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:34 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:36 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:37 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9d30
Jul 29 20:37:38 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:40 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:42 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:44 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:44 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9dd0
Jul 29 20:37:45 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9fc0
Jul 29 20:37:46 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:48 PinePhone connmand[2657]: [ofonoext] ERROR! Timeout was 
reached
Jul 29 20:37:48 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:48 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aea3d0
Jul 29 20:37:48 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9b10
Jul 29 20:37:48 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9b30
Jul 29 20:37:48 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aea6d0
Jul 29 20:37:49 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aea850
Jul 29 20:37:50 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16aeab90
Jul 29 20:37:50 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:50 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeade0
Jul 29 20:37:50 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeaad0
Jul 29 20:37:50 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeb080
Jul 29 20:37:52 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:53 PinePhone eg25-manager[2572]: Modem is up for 120 seconds and 
fully ready
Jul 29 20:37:53 PinePhone eg25-manager[2572]: dropping systemd sleep block 
inhibitor
Jul 29 20:37:54 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:56 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeb5d0
Jul 29 20:37:56 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ae9910
Jul 29 20:37:56 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:37:58 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:00 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:02 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:02 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeba70
Jul 29 20:38:04 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:06 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:08 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:09 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aebb10
Jul 29 20:38:10 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:10 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aebd20
Jul 29 20:38:12 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:13 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aebf30
Jul 29 20:38:13 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aec120
Jul 29 20:38:13 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeb850
Jul 29 20:38:13 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aec3c0
Jul 29 20:38:14 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:14 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aec6b0
Jul 29 20:38:15 PinePhone connmand[2657]: [ofonoext] ERROR! Timeout was 
reached
Jul 29 20:38:15 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16acd670
Jul 29 20:38:15 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aeb890
Jul 29 20:38:15 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16acd910
Jul 29 20:38:16 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:17 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking MODEM request GetAll 
0x16acdbb0
Jul 29 20:38:18 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:20 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:21 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16ace050
Jul 29 20:38:21 PinePhone ofonod[2595]: src/slot-manager-
dbus.c:slot_manager_dbus_reply_or_block() blocking IMEI request GetAll8 
0x16aec620
Jul 29 20:38:22 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
Jul 29 20:38:24 PinePhone connmand[2657]: [ofono] ERROR! 
GDBus.Error:org.ofono.Error.NotAvailable: Operation currently not available
[root@PinePhone defaultuser]# 





