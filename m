Content-Type: multipart/mixed; boundary="===============6434235390439208303=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-nofify-v5 PATCH 0/3] ofono_sim_ready_notify
Date: Tue, 08 Feb 2011 14:32:56 +0200
Message-ID: <1297168379-16400-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6434235390439208303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

The missing bitwise-not has been added to the sim, and the patches has
been rebased to current master.

A call to ofono_sim_ready_notify() is now always expected after call to
query_passwd_state.

When ofono_sim_ready_notify() is invoked, it checks that the call is
expected and if needed, retries the query_passwd_state.  Otherwise it
proceeds with sim initialization.

--Pekka


--===============6434235390439208303==--

