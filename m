Content-Type: multipart/mixed; boundary="===============3866619478939167740=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: Re: obtain HFP disconnection event reason code
Date: Fri, 09 Mar 2012 17:30:57 -0600
Message-ID: <CAB7rCTimXWKSzpZCGaex=DKywnM6HKYZXC+GNHXNgAC-XzQ91A@mail.gmail.com>
In-Reply-To: <CAB7rCThRVZmGensz_bv6rFFS5Pf_BvOiVW4dFjmC6KkoVLgvXQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3866619478939167740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 8, 2012 at 6:09 PM, Mike <puffy.taco@gmail.com> wrote:
> In order to act like a better headset in the HFP HF role, I am in need
> of the reason code from the disconnection event. =C2=A0This is so that I
> can detect when a disconnect occurs as a result of the units moving
> out of range of each other, rather than an intentional disconnect. =C2=A0=
In
> the event of a disconnection based on connection loss, I can then
> periodically re-attempt the connection. =C2=A0I have not seen any D-Bus
> messages that would indicate such an event.
>
> Any ideas on how to obtain this? =C2=A0I can see that in the hciops versi=
on
> of bluez, the reason code makes it into bluetoothd just because the
> entire disconnect event is transferred. =C2=A0This is not the case in the
> mgmtops version. =C2=A0It looks like the reason code also hops along the
> L2CAP path, but I haven't yet tracked down where it ends up. =C2=A0I think
> ideally it would end up somewhere that Ofono would be able to obtain
> it.
>
> Thanks,
> Mike

Alright, looks like the value shows up if I query SO_ERROR in Ofono
when I get POLLERR/POLLHUP in the RFCOMM socket's poll routine.  That
leaves it as an Ofono implementation task then; the bluez side is good
to go.

I'll keep playing with it.

Mike

--===============3866619478939167740==--

