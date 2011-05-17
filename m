Content-Type: multipart/mixed; boundary="===============8625869584444843693=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: In band Tones and announcements
Date: Mon, 16 May 2011 23:45:05 -0500
Message-ID: <4DD1FD51.80702@gmail.com>
In-Reply-To: <BANLkTinz5GuwMB0XqFCCwK275JniwvUgGg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8625869584444843693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On 05/17/2011 02:44 AM, Arun Ravindran wrote:
> Hi,
> =

> Is there support for inband tones/announcement in ofono, if not is there
> any plan to implement/support this in ofono?
> =

> Is org.ofono.AudioSettings interface meant for this, (but all the
> properties seem EXPERIMENTAL now)?
> =


Announcements are really up to the audio policy / media framework.  As
far as I'm aware there are no AT commands associated with them.

In-band tones are a similar matter, they belong to the audio policy /
media framework.  For these I can imagine AT commands being called, but
if they are, then it is really up to the modem driver to provide a
custom interface for these.

Regards,
-Denis

--===============8625869584444843693==--

