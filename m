Content-Type: multipart/mixed; boundary="===============5762313258866051281=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Huawei EC1260 not working
Date: Sat, 02 Oct 2010 16:02:34 +0300
Message-ID: <4CA72D6A.1080501@canonical.com>
In-Reply-To: <AANLkTikRykAxpQuLV23AwErwZ+VivV0X3fjncUzPrZRf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5762313258866051281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/02/2010 02:08 PM, Debayan Banerjee wrote:
> On 2 October 2010 16:28, Debayan Banerjee <debayanin@gmail.com> wrote:
>> 2010/10/2 Debayan Banerjee <debayanin@gmail.com>:
>>> On 2 October 2010 12:42, Debayan Banerjee <debayanin@gmail.com> wrote:
>>>>>
>>>>> I built 0.61, which is the latest stable release. Still no luck :(
>>>>
>>>> i can see a new interface for the modem in ofono in d-feet dbus
>>>> debugger but connman still does not show this device.
> =

> =

> I applied a patch that valo suggested. Here is the debug logs. Seems
> to have worked

Eventually we find out that Huawei EC1260 is a cdma modem and not
supported by ofono currently.

This is too bad. Is anyone currently working on ofono cdma support?

Kalle

--===============5762313258866051281==--

