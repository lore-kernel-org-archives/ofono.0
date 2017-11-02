Content-Type: multipart/mixed; boundary="===============4642515011436255298=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simutil: Made UMTS/GSM authenticate more consitent
Date: Thu, 02 Nov 2017 11:38:17 -0500
Message-ID: <148eaffd-b68c-e813-9d4f-8b3635aab1a4@gmail.com>
In-Reply-To: <1509557537-15050-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4642515011436255298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/01/2017 12:32 PM, James Prestwood wrote:
> The Le parameter in the AUTHENTICATE command was not being
> set for GSM authentication. This did work, but explicitly
> setting it to 0 as UMTS does was more consitent.
> ---
>   src/simutil.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4642515011436255298==--

