Content-Type: multipart/mixed; boundary="===============8445940755159971219=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] modem: Make it possible to identify the physical device
 of the modemy
Date: Thu, 01 Nov 2012 07:39:25 -0500
Message-ID: <50926D7D.9040303@gmail.com>
In-Reply-To: <20121101161608.GH26158@xiaoyu.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8445940755159971219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

>> Why don't you simply assign a name to the modem using
>> ofono_modem_set_name.  This can be done by assigning the name
>> directly in the udev rule and having the necessary magic inside
>> plugins/udev.c. The name can be anything you wish in that case.
>
> I will have to take a look at this. I never wrote advanced udev
> rules and I don't know how much sense it makes to put handling
> for our product into plugins/udev.c.
>

How is your modem array probed / detected by ofono now?

Regards,
-Denis


--===============8445940755159971219==--

