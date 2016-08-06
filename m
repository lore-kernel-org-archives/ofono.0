Content-Type: multipart/mixed; boundary="===============7392046859873974610=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: query facility during initialization in chain manner
Date: Sat, 06 Aug 2016 10:52:56 -0500
Message-ID: <57A607D8.6020909@gmail.com>
In-Reply-To: <1470457426-10949-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7392046859873974610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Samrat,

On 08/05/2016 11:23 PM, Samrat Guha Niyogi wrote:
> query facility during initialization is modified from back
> to back invocation to chain manner to keep it inline with
> RIL design. All vendor RIL does not support back to back
> handling since RIL telephony framework sends the request
> synchronously.
> ---
>   src/sim.c | 42 ++++++++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 16 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============7392046859873974610==--

