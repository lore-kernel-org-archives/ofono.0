Content-Type: multipart/mixed; boundary="===============5494730484277482240=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] isimodem: Use correct callback for pin status
Date: Mon, 11 Sep 2017 10:37:36 -0500
Message-ID: <a738a940-a275-1a19-254f-cc82d2ff046e@gmail.com>
In-Reply-To: <20170910184104.GC3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5494730484277482240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clayton,

On 09/10/2017 01:41 PM, Clayton Craft wrote:
> Hi Denis,
> Ah, ok, I think see what you mean. Sorry for the misunderstanding, and =

> thank
> you for your patience. I have now implemented a proper query method
> based on the 2010 patch you referenced. I don't have a PIN set on my
> SIM, but it seems to allow the 'enabling' to proceed successfully and
> based on my understanding of what the 2010 patch is doing, allow for
> signaling if a SIM is locked as well.
> =

> -Clayton
> =

> drivers/isimodem/sim.c | 27 +++++++++++++++++++++++++--
> 1 file changed, 25 insertions(+), 2 deletions(-)
> =



I went ahead and applied this patch.  Thanks!

Regards,
-Denis

--===============5494730484277482240==--

