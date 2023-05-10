Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED4125B8
	for <ofono@lists.linux.dev>; Wed, 10 May 2023 15:32:25 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3062b101ae1so4798786f8f.2
        for <ofono@lists.linux.dev>; Wed, 10 May 2023 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732743; x=1686324743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XrzBCAgl4qRulqgNaHZwSa5TcD3MSQLcd5RmDN+E75I=;
        b=qZa51Up+OqWqItymfdABXqXBEQvkZaIVFgQL9Z1NVamx9yGiejknuF25OiY4/D5S/I
         CFIKr2UY93zVc5alnx2HrKKHXmNEW5CFn3SPfsdjnMdjHqe8f2vyr3khTTOkym4jnVOW
         Hm3bxsRpULBansVqUxyGUHFoYYloz7Rnv8SL0xF+QT2hWE0ZQYDQXSC8/sH2VMMY8dpo
         jRZKUMyKtjundXREx7IHddg8DtpfYfyO0996cVjbK78suAQUX9Yyoh3WIN6ilQ0rsQ2z
         nQGWDgcDn6dzSxSQs/trMbN6RKBiA5W9c9yjfvuD9AcUH8O4CLURUK3rGhVmrlj76Uov
         sLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732743; x=1686324743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrzBCAgl4qRulqgNaHZwSa5TcD3MSQLcd5RmDN+E75I=;
        b=Qkw64iEyfUEveWnmn3S/qJ5NBttkR2v44md9uLL4NyZaDJdaw/V2bilu1ttFIncwHZ
         RWFTcVY2yDpnFi9m/PRre8/gJb19wNWWdJbxLcxoWD43EEr5w8Vkumxzwdc5hCwGLqkf
         VB/B6nKake2+twPvha/pbSg9cGyaetHNaRJDZKJLnMf5ZHG6VYIVlz+WhBi8nxNRIsQg
         OaWu03J+wn0wI7WepVvy3Dzlwj0AZw8qQV5KuxoH6bigNBF8bB1VwrSCYVoUFsvfvAIp
         F2ClBnFhnMekSeQQAywOD5EdFkLCLKoP4pNtqczIt4wICcVISow3T5KDSjBEQkL0BzTT
         TF1g==
X-Gm-Message-State: AC+VfDwMg9ygrF2rUGVt73uTikH7z/4raZ/csabFugjsdQCl+CGprh/z
	bBbjhgwk7bcUWmsNFY9bugz6PRqvva4=
X-Google-Smtp-Source: ACHHUZ5m4/i7C3eULRENv/8CyeLzhFcwLaFdSipp5jbZP2XKUnKCq3+bPQBefH0aYRjSOuZ/RTp0aQ==
X-Received: by 2002:a5d:4745:0:b0:306:3ad3:94f2 with SMTP id o5-20020a5d4745000000b003063ad394f2mr12427064wrs.42.1683732742849;
        Wed, 10 May 2023 08:32:22 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.242.101.28])
        by smtp.gmail.com with ESMTPSA id x10-20020adfffca000000b002e61e002943sm17599236wrs.116.2023.05.10.08.32.22
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:32:22 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Subject: USB Hub resets - EG25 / Pinephone Pro
Date: Wed, 10 May 2023 16:32:22 +0100
Message-ID: <3234634.44csPzL39Z@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi

Im just really seeking some ideas on how to handle the modem in the pinepho=
ne=20
pro.

Initially, all is good, and the modem works, however, after enabling power=
=20
management and allowing the phone to suspend/resume, ive hit a problem wher=
e=20
on resume, the usb hun the modem is connected to resets.  This causes the=20
modem to dissapear/reappear.

When it re-appears, my debugging has found that devices probed initially ar=
e=20
now not present (a usbmisc and wwan device), however, the 3 modem tty devic=
es=20
are there. See below from some debug logs

This causes the ofono plugin to not register a device (the wwan device is=20
required for this), which isnt ideal on a mobile phone.

Any ideas are welcomed on how to handle this.

Kind Regards

Adam Pigg




    On Boot:
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/udevng.c:create_modem=
()=20
/sys/devices/platform/fe3c0000.usb/usb1/1-1
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/udevng.c:create_modem=
()=20
driver=3Dquectelqmi
    May 08 18:14:10 PinePhonePro ofonod[353]: src/modem.c:ofono_modem_creat=
e()=20
name: (null), type: quectelqmi
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /sys/devices/platform/fe3c0000.usb/usb1/1-1
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB0 255/255/255 00 (null) tty
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB1 255/0/0 01 (null) tty
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB2 255/0/0 02 (null) tty
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB3 255/0/0 03 (null) tty
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/cdc-wdm0 255/255/255 04 (null) usbmisc
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() wwan0 255/255/255 04 (null) net
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() qmi=3D/dev/cdc-wdm0 net=3Dwwan0
    May 08 18:14:10 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() qmi=3D/dev/cdc-wdm0 net=3Dwwan0
    =E2=80=8B
    =E2=80=8B
    On Resume:
    May 08 18:15:05 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /sys/devices/platform/fe3c0000.usb/usb1/1-1
    May 08 18:15:05 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB0 255/255/255 00 (null) tty
    May 08 18:15:05 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB1 255/0/0 01 (null) tty
    May 08 18:15:05 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB2 255/0/0 02 (null) tty
    May 08 18:15:05 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() /dev/ttyUSB3 255/0/0 03 (null) tty
    May 08 18:15:05 PinePhonePro ofonod[353]: plugins/
udevng.c:setup_quectelqmi() qmi=3D(null) net=3D(null)
    =E2=80=8B



