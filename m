Content-Type: multipart/mixed; boundary="===============7500021523168211730=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: Re: [fix-isi-udev PATCH 0/3] Improve udev with isi
Date: Fri, 08 Oct 2010 11:45:13 +0300
Message-ID: <4CAEDA19.9080506@nokia.com>
In-Reply-To: <1286480461.9665.558.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7500021523168211730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.10.2010 22:41, ext Aki Niemi wrote:
>> [fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB ids
>
> This one was left dangling; let's see if we can come up with a better
> way to match the modems driven by cdc_phonet. (Although, admittedly this
> same approach is already used with some AT modems.)

I suppose you could match by usb interface class and subclass? (02 and 254 =

respectively -  the first is standardized, but the second seems to be just =

made up by Nokia at some point, so we better keep the vendor id too)

Alex

--===============7500021523168211730==--

