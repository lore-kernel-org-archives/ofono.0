Content-Type: multipart/mixed; boundary="===============5861026512886061009=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/4] plugins: gemalto: fix incomplete at-chat shutdown
Date: Tue, 18 Aug 2020 09:33:14 -0500
Message-ID: <7f213a9f-4fcd-dca9-c643-dd79c440c435@gmail.com>
In-Reply-To: <13183792-de6e-c20d-cfbb-e9d86a136153@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5861026512886061009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>> Instead of this dance of opening / closing the chat in order to force-ca=
ncel =

>> the 'AT' command queued in gemalto_enable(), maybe there should be somet=
hing =

>> in GAtChat itself to handle this case.  =


<snip>

> =

> There's also the retry logic used on quectel modems with auto-detection o=
f baud =

> rates:
> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/quect=
el.c#n1082
> =


Ah right, I completely forgot about g_at_chat_retry that you added for exac=
tly =

the use case I outlined above.  Thanks for the reminder.

Maybe we should just add this modem poking logic into =

drivers/atmodem/atutil.[ch] or something if it will be used across multiple=
 drivers.

Regards,
-Denis
--===============5861026512886061009==--

