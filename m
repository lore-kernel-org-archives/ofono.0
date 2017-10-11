Content-Type: multipart/mixed; boundary="===============8252164339088143335=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 01/11] simutil: Added app type to application parser
Date: Wed, 11 Oct 2017 10:29:49 -0500
Message-ID: <8bc3fc63-ff80-780f-2967-2aa5bfad9b87@gmail.com>
In-Reply-To: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8252164339088143335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/10/2017 04:36 PM, James Prestwood wrote:
> Parsing a SIM application only copied the 16 byte AID
> portion, which included the application type. Parsing out
> the type makes sorting much easier for modules using the
> parser.
> ---
>   src/simutil.c |  2 ++
>   src/simutil.h | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============8252164339088143335==--

