Content-Type: multipart/mixed; boundary="===============0604868894712184680=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Call Logs
Date: Mon, 06 Jun 2011 15:12:12 -0500
Message-ID: <4DED349C.70709@gmail.com>
In-Reply-To: <BANLkTina8iSM1tgBK738OHDe7pOo-NtPug@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0604868894712184680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rishi,

On 06/08/2011 09:18 AM, Rishi Kumar wrote:
> Hi,
> =

> One Quick question. Does oFono Support any Call Loggin mechanism ???
> It says that it handles call history via plugin interface and not
> directly.
> Can anyone please elaborate on the same ??
> =


Please look into examples/history.c, it implements the history plugin
interface that is notified of any outgoing / incoming / missed calls and
sent / received SMS messages.

Regards,
-Denis

--===============0604868894712184680==--

