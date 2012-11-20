Content-Type: multipart/mixed; boundary="===============3664948301238636086=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 4/4] bluetooth: Fix Device PropertyChanged
Date: Tue, 20 Nov 2012 10:06:04 -0300
Message-ID: <CAKT1EBeVo-3mvM3kmbvro=pnWSkAq-UwZyfkqMtUQmRK2fY83w@mail.gmail.com>
In-Reply-To: <50AB7AC7.2020306@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3664948301238636086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Nov 20, 2012 at 9:42 AM, Daniel Wagner <wagi@monom.org> wrote:
> Hi Claudio,
>
>
> On 20.11.2012 13:12, Claudio Takahasi wrote:
>>
>> BlueZ PropertyChanged signal for Device objects was replaced by
>> PropertiesChanged emitted on org.freedesktop.DBus.Properties interface.
>
>
> Do I understand this correctly, we will not support older BlueZ after this
> change? I would expect that we support 4.x and 5.x at the same time for a
> while.
>
> cheers,
> daniel
>

The patch series that I sent is not BlueZ backward compatible. AFAIK,
there isn't a clean way to detect which BlueZ version is running.
One alternative(hackish) is to fallback if a given method call fails
and add two different signal watchers for PropertiesChanged and
PropertyChanged.

Marcel/Denis: Do you want me to add code keep oFono compatible with
older BlueZ versions?
IMO, I don't think the effort worst, it will become a mess to
implement external hfp profile on oFono. Another point is: if the plan
is to create the modem when the new connection is notified instead of
when the Bluetooth device is created/paired it may introduce problems
to keep the code compatible.

Regards,
Claudio

--===============3664948301238636086==--

