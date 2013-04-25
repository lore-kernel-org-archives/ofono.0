Content-Type: multipart/mixed; boundary="===============0286235969963152087=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Thu, 25 Apr 2013 17:48:05 -0500
Message-ID: <5179B2A5.3030001@gmail.com>
In-Reply-To: <20130425174733.GB20988@samus>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0286235969963152087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

>>> Both the NewConnection() (including the authorization of the incoming
>>> L2CAP/RFCOMM connect request) and the Paired property would even then be
>>> delayed until our side has completed its full service discovery.
>>>
>>
>> So should we be reverting commit 456b8c9723b9b73c3ea4cadc8c6f84ca90675f9=
a?
>
> I guess so. Without that commit this problem doesn't exist.
>

I went ahead and reverted this.

Regards,
-Denis

--===============0286235969963152087==--

