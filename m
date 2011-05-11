Content-Type: multipart/mixed; boundary="===============8566582298305910382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] reopen data device once if open data device failed
Date: Tue, 10 May 2011 22:45:38 -0500
Message-ID: <4DCA0662.6090101@gmail.com>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A057B5DE@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8566582298305910382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

>> I think this is wrong as well. We should remove that context no matter
>> if online of offline, but off course you do not wanna create a new GPRS
>> context if you are actually offline, right?
>>
> =

> If the device is offline, the GPRS context atom has been released when set
> the device to offline. That's another issue has been fixed by Martin (Need
> set data->gc to NULL, because it has been release if device is offline).
> =

> It will create a new GPRS context when the device is switch to online(in
> huawei_post_online()), so don't create it here if it is offline.
> =

>

I suggest you migrate the huawei modem driver to create the gprs atom in
post_sim state instead of post_online.  It will solve many of the issues
you're trying to solve.

Regards,
-Denis

--===============8566582298305910382==--

