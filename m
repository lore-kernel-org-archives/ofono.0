Content-Type: multipart/mixed; boundary="===============8831857220812106307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add support to huawei e173
Date: Tue, 31 May 2011 12:52:49 -0500
Message-ID: <4DE52AF1.8030607@gmail.com>
In-Reply-To: <BANLkTi=po+QnDZeDJWvVCnCx2kUfbVJSbg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8831857220812106307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leonardo,

On 05/31/2011 12:45 PM, Leonardo Luiz Padovani da Mata wrote:
> Hello Denis, how are you?
> =

> On Tue, May 31, 2011 at 1:47 PM, Denis Kenzior <denkenz@gmail.com
> <mailto:denkenz@gmail.com>> wrote:
> =

>     Hi Leonardo,
> =

>     On 05/30/2011 04:11 PM, Leonardo Luiz Padovani da Mata wrote:
>     > hello dudes, what i need to do to check if the implemented drivers =
are
>     > enough to support a modem? Do i just need to add the rules for
>     udev? how
>     > do i do that?
>     >
>     > The id of the modem is  12d1:1c0b huawei e173
>     >
> =

>     Check plugins/ofono.rules in git.  It looks like a rule is not present
>     for this particular device id.
> =

>     You will have to do some minor poking around to figure out what tty
>     corresponds to what function (e.g. Pcui, Modem, see other Huawei rules
>     for examples), add a new entry to ofono.rules and try to see if it
>     works.
> =

> =

> Ok, i've found another possible soluttion using usb_modeswitch, but it
> didn't work yet:
> http://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?t=3D552
> =

> Do you think that the usb_modeswitch approach is better/worse?

This depends a little bit on how your modem is being recognized.  If it
is recognized as a storage device, then yes, usb_modeswitch will
probably be required.

If it is already recognized as a modem and the rules are not present in
ofono.rules, then you will need to perform the steps I mentioned in my
previous mail.

Regards,
-Denis

--===============8831857220812106307==--

