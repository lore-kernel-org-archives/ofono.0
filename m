Content-Type: multipart/mixed; boundary="===============7667681647430295975=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/3] Updated patches to handle the asynchronized callback
Date: Mon, 29 Mar 2010 21:50:01 +0800
Message-ID: <1269870604-28896-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7667681647430295975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I updated the patches according to the comments and did following changes:

1. removed last_result since it seems no use at all.
2. rename g_at_server_send_flush to g_at_server_send_result. It makes code =
easier to read.
3. add parse_ready flag to parse one command line at one time.

Please review them. Thanks!


--===============7667681647430295975==--

