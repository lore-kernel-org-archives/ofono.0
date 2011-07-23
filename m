Content-Type: multipart/mixed; boundary="===============7972228505720980284=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 2/3] cdmamodem: Create network registration atom.
Date: Sat, 23 Jul 2011 10:23:03 -0500
Message-ID: <4E2AE757.60901@gmail.com>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E133@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7972228505720980284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 07/23/2011 10:15 AM, Aygon, Bertrand wrote:
> Hi Denis,
> =

> =

> <<snip>>
>  =

>> And why are we using a Huawei specific command inside the generic
>> cdmamodem driver without at least a vendor if/switch somewhere?
> =

> We have SpeedUp dongle that also support this command...
> =

> I know this is not the best answer, but there is no standard for CDMA, so=
 many customer seems to se the same AT command.
> =


Just because you saw two manufacturers doing this, it does not mean that
every one of them will, especially since many use qcdm for this info.
This either belongs in huaweicdma directory or behind a vendor quirk.

Regards,
-Denis

--===============7972228505720980284==--

