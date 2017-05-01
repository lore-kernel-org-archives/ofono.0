Content-Type: multipart/mixed; boundary="===============1334441526255094812=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/3] handsfree-audio: Add Acquire method
Date: Mon, 01 May 2017 10:59:12 -0500
Message-ID: <705c0e55-1889-4324-6f19-35ecd0cc0e40@gmail.com>
In-Reply-To: <20170428093108.29461-3-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1334441526255094812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On 04/28/2017 04:31 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds Acquire method which can be used by agents that require
> pulling the fd directly instead of waiting a NewConnection.
>
> Note: sounds servers like PulseAudio do auto suspend stream when idle
> for a certain amount of time and once anything happens it will resume
> the stream, though this all happens in the so called IO thread in a
> blocking fashion making it impossible to receive the fd via NewConnetion
> causing the stream to fail to resume. There are other forms to work
> around but this seems to be most convenient as we do want the auto
> suspend feature to work properly and letting the stream to fail to
> resume may create unexpected artifacts while the NewConnection is
> handled in PA main thread.
> ---
>  doc/handsfree-audio-api.txt | 16 ++++++++++++++++
>  src/handsfree-audio.c       |  9 +++++++++
>  2 files changed, 25 insertions(+)
>

I'm fine with this one, but please separate it into two commits.  See =

HACKING, 'Submitting patches', item 3.

Regards,
-Denis


--===============1334441526255094812==--

