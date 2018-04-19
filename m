Content-Type: multipart/mixed; boundary="===============4312528570958030859=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] SIM detection: Fixing the logical error in using the
 number of slot and number of application
Date: Thu, 19 Apr 2018 10:31:45 +0200
Message-ID: <1524126706-16730-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <d5d829e1-8d90-b396-9427-30b5980be834@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4312528570958030859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Japanese SIM card which is not detected because of this issue.
So I would like to see this patch included.

Here is a version of the patch using git send-email.
I don't know how to say that Eswaran Vinothkumar is the author.
I hope you can fix that.

Best Regards,

Christophe

Christophe Ronco (1):
  qmi: use right slot and application during SIM detection

 drivers/qmimodem/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- =

2.7.4


--===============4312528570958030859==--

