Content-Type: multipart/mixed; boundary="===============7934144275737397347=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/1] ublox: create only 1 gprs context
Date: Thu, 14 Mar 2019 20:27:54 -0500
Message-ID: <1883c433-e0e2-6086-e396-583bcc438f26@gmail.com>
In-Reply-To: <20190314223726.9494-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7934144275737397347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/14/2019 05:37 PM, Jonas Bonn wrote:
> ---
> =


Funny, I was looking at this code today and thought it was wrong.  Was =

going to point this out to you, but you beat me to it ;)

> Here's something that I'm having trouble understanding.  The ublox
> plugin creates 8 gprs_context atoms.  As far as I can tell, this means
> that ofono will allow it to activate 8 contexts simultaneously... right?
>

Correct.  Each context driver added to gprs allows a concurrent context =

to be activated.  E.g. if you have 2 drivers, you can activate 2 =

contexts simultaneously.  Obviously you need a high speed / ppp =

interface for each active context.

> Why is the ublox plugin the only one that does this?  Do other modems
> not support multiple active contexts?  Or is this plugin wrong?

 From what I recall, ublox does claim to support multiple PDP contexts =

active at the same time.  However, I don't know how this works in =

practice as you need a unique network interface for each one.  As it =

stands today, given the udevng detection logic, this plugin is wrong.

> =

> If I were to follow the model of other plugins, the below patch would
> seem appropriate...
> =

> A bit of insight here would be appreciated.

There are drivers for USB based modems that do this properly.  See =

xmm7xxx for example.  Multiple PDP context support was added to that =

recently.

Modems that used multiplexing had support for multiple PDP contexts for =

quite some time.  E.g. plugins/ifx, etc.

Anyway, patch looks fine to me.  Let me know if you want me to apply it =

or you want to take a stab at fixing the detection logic.

Regards,
-Denis

--===============7934144275737397347==--

