Content-Type: multipart/mixed; boundary="===============5027667472958082649=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/modem.c/call_watches null pointer check
Date: Tue, 23 Oct 2018 09:30:22 -0500
Message-ID: <afe90723-1a43-90fd-02cc-7a44cd610818@gmail.com>
In-Reply-To: <20181023075039.13587-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5027667472958082649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/23/2018 02:50 AM, Giacinto Cifelli wrote:
> check the pointer modem->atom_watches, that can be null when the
> function is called during the disable/remove of the device,
> for example when it is unplugged or switched off.

If this caused a crash, a full stack trace would be helpful and should =

be part of this commit description.

Regards,
-Denis

--===============5027667472958082649==--

