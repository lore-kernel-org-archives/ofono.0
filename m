Content-Type: multipart/mixed; boundary="===============5419890772048069813=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: SAT support in oFono
Date: Fri, 21 Jan 2011 11:12:20 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802DA0839@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <3A42A4F4F2ABA44EBD5853ED099266471247BFC116@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5419890772048069813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

ofono-bounces(a)ofono.org wrote:
> Hi
> =

> I am checking what is the level of SAT/STK support in ofono
> and have a couple of questions. The current implementation
> contains support for basic STK commands, like menus, inputs,
> calls, sms and so on. In TODO, there is only REFRESH command
> on the list.
> =

> Is there plans or ideas to extend the support in oFono Core
> with more complex STK features like (3GPP TS 31.111):
> - Call control by USIM
> - MO SMS Control by USIM

Most of the modems support call control, MO SMS control on the firmware
side itself.
Open for adding support in ofono.

> - BIP (Bearer independent protocol), including commands like
> OPEN CHANNEL, CLOSE CHANNEL, SEND/RECEIVE DATA

Inorder to support class e fully, changes are required in connman and
ofono.
Since class e is an optional one, I dont think we need to support this
inorder to get GCF certified.

for your question, is there any plan to support this in oFono core, =

I would leave it to Denis, Andre and Marcel to comment on this.

> - Extend support in PROVIDE LOCAL INFO

Same here, don't need to support this inorder to get GCF certified. =


> - EVENT DOWNLOAD / SET UP EVENT LIST
>

Most of the modem firwares support the event download of MT CALL,
connected, disconnected etc. Its been
discussed in irc, that there is no plans to add support for
UserActivity,
IdleScreen available events. Denis can confirm this.

Regards,
Jeevaka


--===============5419890772048069813==--

