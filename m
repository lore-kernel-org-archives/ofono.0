Content-Type: multipart/mixed; boundary="===============0736066249571378018=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/5] Prototype to handle asynchronized callback
Date: Thu, 25 Mar 2010 21:48:16 +0800
Message-ID: <1269524901-1745-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0736066249571378018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

These patches are the prototype to handle the asynchronized callback
for AtServer.

During the callback function execution period, GAtServer waits for its
result and then process next command. At the same time, the server is
capable to accept new data comes from the client side and cache them in
the read buffer.

Please review them. Any comments are welcome!

In-Reply-To: =



--===============0736066249571378018==--

