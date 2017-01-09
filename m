Content-Type: multipart/mixed; boundary="===============1373205349954297522=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Fix Read Imsi feature for MC7430 modem
Date: Mon, 09 Jan 2017 12:32:07 -0600
Message-ID: <aeb31587-528d-67cb-7d52-dac35dd0ebdc@gmail.com>
In-Reply-To: <20170109083407.3980-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1373205349954297522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 01/09/2017 02:34 AM, Christophe Ronco wrote:
> Done in 2 patches:
>  - Backup read imsi modem driver funtion by IMSI via EF read (what is done
> now when read_insi is not defined in modem driver)
>  - Implement read_imsi in qmimodem sim driver
>
> Christophe Ronco (2):
>   sim: backup driver read_imsi by IMSI via EF read
>   qmimodem: Add read_imsi to qmimodem sim driver
>
>  drivers/qmimodem/sim.c | 83 ++++++++++++++++++++++++++++++++++++++++++++=
++----
>  src/sim.c              | 33 ++++++++++++--------
>  2 files changed, 97 insertions(+), 19 deletions(-)
>

Both applied, thanks!

Regards,
-Denis

--===============1373205349954297522==--

