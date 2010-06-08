Content-Type: multipart/mixed; boundary="===============1743882388128967478=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Huawei E1552 broken
Date: Tue, 08 Jun 2010 13:54:47 +0300
Message-ID: <87mxv5zte0.fsf@potku.valot.fi>
In-Reply-To: <33AB447FBD802F4E932063B962385B351EAD924E@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1743882388128967478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Zhang, Zhenhua" <zhenhua.zhang@intel.com> writes:

> Hi Kalle,

Hi Zhenhua,

> Kalle Valo wrote:
>> Hi,
>> =

>> I mentioned this briefly on irc, but I'll inform it here as well. This
>> patch broke ofono support for my Huawei E1552:
>> =

>> commit 6ab0b6f29acc8f6b2a5f3b94c02c405ee7318244
>> Author: Marcel Holtmann <marcel@holtmann.org>
>> Date:   Sun Jun 6 15:51:36 2010 -0700
>> =

>>    Fix detection of Huawei E220 and E270 modems
>> =

>> Huawei plugin uses /dev/ttyUSB1 for the event channel but for my modem
>> it should be /dev/ttyUSB2. We need to solve this problem somehow, even
>> if we need to add usb ids to ofono.rules.
>
> Denis has already updated udev.c by commit 71ea72adf and now it
> detects interface number by ofono.rules.

Oh damn, I forgot to do git update this morning and missed this
altogether. Thank you for pointing out this.

> So I think you should add one more E1552 specific item in ofono.rules
> with your product id and interface number, etc.

Actually Denis already added them. Excellent, thank you Denis! My modem
works again :)

But now connman doesn't show the operator name "Saunalahti" anymore, the
name property in connman Service is just empty:

./cmcc show cellular_244053111242822_huawei0_primarycontext1
AutoConnect: true
Name: =

Nameservers: { 193.229.0.40 193.229.0.42 }
Proxy: { Method=3Ddirect }

-- =

Kalle Valo

--===============1743882388128967478==--

