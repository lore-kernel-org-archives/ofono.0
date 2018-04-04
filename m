Content-Type: multipart/mixed; boundary="===============4125003289405621297=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] qmi: unify common request header setup
Date: Wed, 04 Apr 2018 10:00:34 -0500
Message-ID: <b332406a-b0af-9e83-43ee-3fd50b3d65eb@gmail.com>
In-Reply-To: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4125003289405621297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/03/2018 09:50 AM, Jonas Bonn wrote:
> The service and control requests differ slightly in their headers, but
> this difference is minor enough that we can handle it directly in the
> request submission routine.  This patch unifies the header setup for the
> two request types.
> ---
>   drivers/qmimodem/qmi.c | 68 +++++++++++++++++++++++--------------------=
-------
>   1 file changed, 31 insertions(+), 37 deletions(-)
> =


Patches 1-4 applied, thanks.

Regards,
-Denis


--===============4125003289405621297==--

