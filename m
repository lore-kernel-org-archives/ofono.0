Content-Type: multipart/mixed; boundary="===============6050799893966078755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Deactivate old contexts on attach
Date: Mon, 04 Apr 2016 14:48:21 -0500
Message-ID: <5702C505.3040200@gmail.com>
In-Reply-To: <1459786308-11511-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6050799893966078755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 04/04/2016 11:11 AM, Alfonso Sanchez-Beato wrote:
> In some cases it is possible that a context is opened after a detach
> event has been received, and right before an attach, depending on the
> modem. We make sure that those contexts are removed to keep
> consistency.
> ---
>   src/gprs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============6050799893966078755==--

