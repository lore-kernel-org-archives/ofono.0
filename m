Content-Type: multipart/mixed; boundary="===============1276829504178173352=="
MIME-Version: 1.0
From: Zhao Forrest <forrest.zhao@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Thu, 21 Jan 2010 07:54:43 +0000
Message-ID: <ac8af0be1001202354i7f1a98dbw55c56fc65f878358@mail.gmail.com>
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1276829504178173352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Your patch removes many DBus APIs provided by audio/gateway.c, which
was originally designed to provide a set of DBus functions/signals for
ease of application development. In other words, your patch is too
oFono-specific, and is not a general support for HFP HF unit role in
BlueZ IMO. The DBus interface provided by your patch is not easy to
develop the application because the application developer has to parse
the AT commands by himself. I know that oFono could parse AT commands.
But I don't think it a common case for other application developers.
Why not extend audio/gateway.c instead of removing its DBus APIs or
create a new file to support HFP for oFono in blueZ?

I think maybe Marcel would have more comments on this to give a clear direc=
tion.

Thanks,
Forrest

On Thu, Jan 21, 2010 at 3:58 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>> New version of the patches. Known issues:
>> "'org.bluez.HandsfreeAgent.Release' part not implemented" and it's not
>> working with more than one bluetooth devices in some cases. Comments
>> are welcome.
>>
>
> Another new version of the patches. Now ofono query all bluetooth
> devices and searches for the ones with Gateway interface.
> Bluez has some fixes and now supports connection coming from the AG.
> The patches are using a per-device agent as described by the last
> version of Handsfree API.
>
> I did not implemented yet 'org.bluez.HandsfreeAgent.Release'.
>
> Comments are welcome. :)
>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>

--===============1276829504178173352==--

