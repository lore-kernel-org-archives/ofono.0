Content-Type: multipart/mixed; boundary="===============7292395924445925078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gemalto: radio-settings: cleanup
Date: Tue, 27 Jul 2021 09:31:05 -0500
Message-ID: <16dadbd1-6922-a554-6297-393693d91796@gmail.com>
In-Reply-To: <20210723170001.12102-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7292395924445925078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 7/23/21 12:00 PM, Sergey Matyukevich wrote:
> Enum ofono_radio_access_mode has been replaced by unsigned int.
> This change allows to move handling of all the modes into
> 'switch' in the function gemalto_set_rat_mode.
> ---
>   drivers/gemaltomodem/radio-settings.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7292395924445925078==--

