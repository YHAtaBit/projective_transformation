tr_x = 40
tr_y = 40
tl_x = 10
tl_y = 40
br_x = 40
br_y = 10
bl_x = 10
bl_y = 10

h_tr_x = 50
h_tr_y = 50
h_tl_x = 0
h_tl_y = 50
h_br_x = 50
h_br_y = 0
h_bl_x = 0
h_bl_y = 0

mat = matrix(c(bl_x, bl_y, 1, 0, 0, 0, -bl_x*h_bl_x, -bl_y*h_bl_x,
               0, 0, 0, bl_x, bl_y, 1, -bl_x*h_bl_y, -bl_y*h_bl_y,
               tl_x, tl_y, 1, 0, 0, 0, -tl_x*h_tl_x, -tl_y*h_tl_x,
               0, 0, 0, tl_x, tl_y, 1, -tl_x*h_tl_y, -tl_y*h_tl_y,
               tr_x, tr_y, 1, 0, 0, 0, -tr_x*h_tr_x, -tr_y*h_tr_x,
               0, 0, 0, tr_x, tr_y, 1, -tr_x*h_tr_y, -tr_y*h_tr_y,
               br_x, br_y, 1, 0, 0, 0, -br_x*h_br_x, -br_y*h_br_x,
               0, 0, 0, br_x, br_y, 1, -br_x*h_br_y, -br_y*h_br_y), nrow = 8, ncol = 8)


mat = t(mat)
dst = matrix(c(0, 0, 0, 50, 50, 50, 50, 0), ncol = 1)

ans = solve(mat) %*% dst


homography = c(ans, 1)
homography = matrix(homography, nrow = 3, ncol = 3)
homography = t(homography)

X = c(10, 10, 40, 40)
Y = c(10, 40, 40, 10)
data = data.frame(X, Y)

d = apply(data, 2, c)
null = matrix(rep(0, 3*nrow(data)), ncol = nrow(data))
for (i in 1:nrow(data)){
  null[, i] = matrix(c(d[i,], 1), ncol = 1)
}
aru = null

null = matrix(rep(0, 3*nrow(data)), ncol = nrow(data))
for (i in 1:ncol(aru)){
  null[, i] = homography %*% aru[,i]
}
dst = null
x = dst[1,]/dst[3,]
y = dst[2,]/dst[3,]

n_X = x
n_Y = y

