Content-Type: multipart/mixed; boundary="===============2733638484397100713=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] unit: add rilmodem test engine
Date: Tue, 25 Oct 2016 11:52:37 -0500
Message-ID: <580F8DD5.6080903@gmail.com>
In-Reply-To: <20161024105707.7731-1-alfonsosanchezbeato@yahoo.es>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2733638484397100713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 10/24/2016 05:57 AM, Alfonso S=C3=A1nchez-Beato wrote:
> Add rilmodem test engine. This engine is an improvement on the rilmodem
> test server that allows us to test generic interactions with the
> rilmodem driver. Instead of just be able to check content of received/
> sent bytes on the rild socket, we can now specify a set of steps for a
> test that include interactions with the atom. The step types are
>
> - TST_ACTION_SEND: The harness sends a parcel
> - TST_ACTION_CALL: The harness calls a driver function
> - TST_EVENT_RECEIVE: The driver sends a parcel
> - TST_EVENT_CALL: The driver calls a harness (atom) function
> ---
>   unit/rilmodem-test-engine.c | 280 +++++++++++++++++++++++++++++++++++++=
+++++++
>   unit/rilmodem-test-engine.h |  74 ++++++++++++
>   2 files changed, 354 insertions(+)
>   create mode 100644 unit/rilmodem-test-engine.c
>   create mode 100644 unit/rilmodem-test-engine.h
>

All 4 applied, thanks.

Regards,
-Denis


--===============2733638484397100713==--

