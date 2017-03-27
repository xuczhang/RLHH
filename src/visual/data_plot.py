import glob
import json
import os
import scipy
import scipy.io
import matplotlib.pyplot as plt
import numpy as np
import operator
from matplotlib import cm
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.ticker import LinearLocator, FormatStrFormatter


class DataPlot:

    def __init__(self):
        self.init_plotting()
        pass

    def init_plotting(self):
        plt.rcParams['figure.figsize'] = (6.5, 5)
        plt.rcParams['font.size'] = 15
        #plt.rcParams['font.family'] = 'Times New Roman'
        plt.rcParams['axes.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['axes.titlesize'] = 20
        plt.rcParams['legend.fontsize'] = 12
        plt.rcParams['xtick.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['ytick.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['savefig.dpi'] = plt.rcParams['savefig.dpi']
        plt.rcParams['xtick.major.size'] = 3
        plt.rcParams['xtick.minor.size'] = 3
        plt.rcParams['xtick.major.width'] = 1
        plt.rcParams['xtick.minor.width'] = 1
        plt.rcParams['ytick.major.size'] = 3
        plt.rcParams['ytick.minor.size'] = 3
        plt.rcParams['ytick.major.width'] = 1
        plt.rcParams['ytick.minor.width'] = 1
        #plt.rcParams['legend.frameon'] = True
        #plt.rcParams['legend.loc'] = 'center left'
        #plt.rcParams['legend.loc'] = 'center left'
        plt.rcParams['axes.linewidth'] = 2

        #plt.gca().spines['right'].set_color('none')
        #plt.gca().spines['top'].set_color('none')
        #plt.gca().xaxis.set_ticks_position('bottom')
        #plt.gca().yaxis.set_ticks_position('left')

    def draw_residual_iter(self):

        mat_contents = scipy.io.loadmat("sort_r_1")
        Y_residual_1 = mat_contents["sort_r"].tolist()

        mat_contents = scipy.io.loadmat("sort_r_2")
        Y_residual_2 = mat_contents["sort_r"].tolist()

        mat_contents = scipy.io.loadmat("sort_r_3")
        Y_residual_3 = mat_contents["sort_r"].tolist()

        mat_contents = scipy.io.loadmat("sort_r_4")
        Y_residual_4 = mat_contents["sort_r"].tolist()

        x = [i for i in range(1, len(Y_residual_1)+1)]
        #plt.xticks(x, xticks)
        # begin subplots region
        #plt.subplot(121)
        plt.gca().margins(0.1, 0.1)
        #plt.plot(x, Y_residual_1, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        #plt.plot(x, Y_residual_2, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        #plt.plot(x, Y_residual_3, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        plt.plot(x, Y_residual_4, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')

        plt.xlabel(u'index')
        plt.ylabel(u'residual')
        #plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.show()


        #pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/diff_phi1.pdf")
        #plt.savefig(pp, format='pdf')
        plt.close()

    def draw_residual(self, matlab_file):

        mat_contents = scipy.io.loadmat(matlab_file)
        Y_residual = mat_contents["sort_r"].tolist()


        x = [i for i in range(1, len(Y_residual)+1)]
        #plt.xticks(x, xticks)
        # begin subplots region
        #plt.subplot(121)
        plt.rcParams['figure.figsize'] = (7, 4)
        plt.gca().margins(0.1, 0.1)

        plt.plot(x, Y_residual, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        #plt.plot(x, Y_pred, linestyle='-', marker='o', markersize=7,linewidth=3, color='#0174DF', label='pred')
        #plt.plot(x, y3, linestyle='-', marker='o', linewidth=2, color='y', label='cos')

        plt.xlabel(u'index')
        plt.ylabel(u'residual')
        #plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.show()


        #pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/diff_phi1.pdf")
        #plt.savefig(pp, format='pdf')
        plt.close()

    def draw_param_score(self, matlab_file):

        mat_contents = scipy.io.loadmat(matlab_file)
        param_score = mat_contents["param_score"].tolist()[500:1200]
        #param_score = mat_contents["param_score"].tolist()


        x = [i for i in range(500, len(param_score)+500)]
        #x = [i for i in range(1, len(param_score) + 1)]
        #plt.xticks(x, xticks)
        # begin subplots region
        #plt.subplot(121)
        plt.rcParams['figure.figsize'] = (5.4, 4.21)
        plt.gca().margins(0.1, 0.1)
        plt.plot(x, param_score, linestyle='', marker='o', markersize=2, linewidth=2, color='#CF4A5A', markeredgecolor='none')
        #plt.plot(x, Y_pred, linestyle='-', marker='o', markersize=7,linewidth=3, color='#0174DF', label='pred')
        #plt.plot(x, y3, linestyle='-', marker='o', linewidth=2, color='y', label='cos')

        plt.xlabel(u'index')
        plt.ylabel(r'$L$-Value')
        #plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.show()


        #pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/diff_phi1.pdf")
        #plt.savefig(pp, format='pdf')
        plt.close()

    def draw_beta_recovery(self, result_dir, k, p, bNoise):

        if bNoise:
            noise_str = ""
        else:
            noise_str = "_nn"

        recovery_file = result_dir + 'beta_' + str(k) + 'K_' + 'p' + str(p) + noise_str + '.mat'
        mat_contents = scipy.io.loadmat(recovery_file)
        Y_OLS = mat_contents["OLS_result"][0].tolist()
        Y_DALM = mat_contents["DALM_result"][0].tolist()
        Y_HOMO = mat_contents["HOMO_result"][0].tolist()
        Y_TORRENT0 = mat_contents["TORRENT0_result"][0].tolist()
        Y_TORRENT25 = mat_contents["TORRENT25_result"][0].tolist()
        Y_TORRENT50 = mat_contents["TORRENT50_result"][0].tolist()
        Y_RLHH = mat_contents["RLHH_result"][0].tolist()

        #x = [i*0.05 for i in range(2, 25)]
        x = [i*0.1 for i in range(1, 13)]
        # plt.xticks(x, xticks)
        # begin subplots region
        # plt.subplot(121)
        plt.gca().margins(0.1, 0.1)
        #plt.plot(x, Y_OLS, linestyle='-', marker='d', markersize=5, linewidth=3, color='blue', label='OLS')
        plt.plot(x, Y_DALM, linestyle='--', marker='o', markersize=5, linewidth=3, color='green', label='DALM')
        plt.plot(x, Y_HOMO, linestyle='-.', marker='v', markersize=5, linewidth=3, color='#5461AA', label='Homotopy')
        plt.plot(x, Y_TORRENT50, linestyle='-.', marker='<', markersize=5, linewidth=3, color='#F27441', label='TORRENT50')
        plt.plot(x, Y_TORRENT25, linestyle='--', marker='s', markersize=5, linewidth=3, color='#BD90D4', label='TORRENT25')
        plt.plot(x, Y_TORRENT0, linestyle=':', marker='^', markersize=5, linewidth=3, color='cyan', label='TORRENT*')
        plt.plot(x, Y_RLHH, linestyle='-', marker='o', markersize=5, linewidth=3, color='red', label='RLHH')

        plt.xlabel(u'Corruption Ratio')
        plt.ylabel(r'$\|\beta - \beta^*\|_2$')

        # plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        # plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        #plt.yscale('log')


        if k == 1 and p == 100 and bNoise == 1:
            plt.ylim(0.1, 0.45)  # used for 1K
        elif k == 2 and p == 100 and bNoise == 1:
            plt.ylim(0.05, 0.45)  # used for 2K
        elif k == 4 and p == 100 and bNoise == 1:
            plt.ylim(0.03, 0.35)  # used for 4K
        elif k == 1 and p == 200 and bNoise == 1:
            plt.ylim(0.15, 0.45)
        elif k == 2 and p == 200 and bNoise == 1:
            plt.ylim(0.1, 0.45)
        elif k == 2 and p == 200 and bNoise == 0:
            plt.ylim(-0.02, 0.45)
        elif k == 4 and p == 400 and bNoise == 0:
            plt.ylim(-0.05, 1.95)
        plt.show()

        #pp = PdfPages("D:/Dropbox/PHD/publications/IJCAI2017_RLHH/images/beta_1.pdf")
        #plt.savefig(pp, format='pdf')
        #plt.close()

    def draw_runtime_cr(self, result_dir, k, p, bNoise):

        if bNoise:
            noise_str = ""
        else:
            noise_str = "_nn"

        runtime_file = result_dir + 'runtime_' + str(k) + 'K_' + 'p' + str(p) + noise_str + '.mat'
        mat_contents = scipy.io.loadmat(runtime_file)
        Y_OLS = mat_contents["OLS_result"][0].tolist()
        Y_DALM = mat_contents["DALM_result"][0].tolist()
        Y_HOMO = mat_contents["HOMO_result"][0].tolist()
        Y_TORRENT50 = mat_contents["TORRENT50_result"][0].tolist()
        Y_TORRENT25 = mat_contents["TORRENT25_result"][0].tolist()
        Y_TORRENT0 = mat_contents["TORRENT0_result"][0].tolist()
        Y_RLHH = mat_contents["RLHH_result"][0].tolist()

        #x = [i*0.05 for i in range(2, 25)]
        x = [i*0.1 for i in range(1, len(Y_RLHH) + 1)]
        # plt.xticks(x, xticks)
        # begin subplots region
        # plt.subplot(121)
        plt.gca().margins(0.1, 0.1)
        #plt.plot(x, Y_OLS, linestyle='-', marker='d', markersize=5, linewidth=3, color='blue', label='OLS')
        plt.plot(x, Y_DALM, linestyle='--', marker='o', markersize=5, linewidth=3, color='green', label='DALM')
        plt.plot(x, Y_HOMO, linestyle='-.', marker='v', markersize=5, linewidth=3, color='#5461AA', label='Homotopy')
        plt.plot(x, Y_TORRENT50, linestyle='-.', marker='<', markersize=5, linewidth=3, color='#F27441', label='TORRENT50')
        plt.plot(x, Y_TORRENT25, linestyle='--', marker='s', markersize=5, linewidth=3, color='#BD90D4', label='TORRENT25')
        plt.plot(x, Y_TORRENT0, linestyle=':', marker='^', markersize=5, linewidth=3, color='cyan', label='TORRENT')
        plt.plot(x, Y_RLHH, linestyle='-', marker='o', markersize=5, linewidth=3, color='red', label='RLHH')

        plt.xlabel(u'Corruption Ratio')
        plt.ylabel(u'Running Time(s)')

        # plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        # plt.yaxis.grid(color='gray', linestyle='dashed')

        #plt.gca().legend(bbox_to_anchor=(0.35, 0.45))
        plt.gca().legend(bbox_to_anchor=(0.40, 0.7))
        #plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.yscale('log')


        if k == 1 and p == 100 and bNoise == 1:
            plt.ylim(0.1, 0.45)  # used for 1K
        elif k == 2 and p == 100 and bNoise == 1:
            plt.ylim(0.05, 0.45)  # used for 2K
        elif k == 4 and p == 100 and bNoise == 1:
            plt.ylim(0.03, 0.35)  # used for 4K
        elif k == 1 and p == 200 and bNoise == 1:
            plt.ylim(0.15, 0.45)
        elif k == 2 and p == 200 and bNoise == 1:
            plt.ylim(0.1, 0.45)
        elif k == 2 and p == 200 and bNoise == 0:
            plt.ylim(-0.02, 0.45)
        elif k == 4 and p == 400 and bNoise == 0:
            plt.ylim(-0.1, 20)
        plt.show()

        #pp = PdfPages("D:/Dropbox/PHD/publications/IJCAI2017_RLHH/images/beta_1.pdf")
        #plt.savefig(pp, format='pdf')
        #plt.close()


    def draw_runtime_datasize(self, result_dir, cr, p, bNoise):

        if bNoise:
            noise_str = ""
        else:
            noise_str = "_nn"

        runtime_file = result_dir + 'runtime_cr' + str(int(cr*100)) + '_' + 'p' + str(p) + noise_str + '.mat'
        mat_contents = scipy.io.loadmat(runtime_file)
        Y_OLS = mat_contents["OLS_result"][0].tolist()
        Y_DALM = mat_contents["DALM_result"][0].tolist()
        Y_HOMO = mat_contents["HOMO_result"][0].tolist()
        Y_TORRENT50 = mat_contents["TORRENT50_result"][0].tolist()
        Y_TORRENT25 = mat_contents["TORRENT25_result"][0].tolist()
        Y_TORRENT0 = mat_contents["TORRENT0_result"][0].tolist()
        Y_RLHH = mat_contents["RLHH_result"][0].tolist()

        #x = [i*0.05 for i in range(2, 25)]
        x = [i for i in range(1, len(Y_RLHH) + 1)]
        # plt.xticks(x, xticks)
        # begin subplots region
        # plt.subplot(121)
        plt.gca().margins(0.1, 0.1)
        #plt.plot(x, Y_OLS, linestyle='-', marker='d', markersize=5, linewidth=3, color='blue', label='OLS')
        plt.plot(x, Y_DALM, linestyle='--', marker='o', markersize=5, linewidth=3, color='green', label='DALM')
        plt.plot(x, Y_HOMO, linestyle='-.', marker='v', markersize=5, linewidth=3, color='#5461AA', label='Homotopy')
        plt.plot(x, Y_TORRENT50, linestyle='-.', marker='<', markersize=5, linewidth=3, color='#F27441', label='TORRENT50')
        plt.plot(x, Y_TORRENT25, linestyle='--', marker='s', markersize=5, linewidth=3, color='#BD90D4', label='TORRENT25')
        plt.plot(x, Y_TORRENT0, linestyle=':', marker='^', markersize=5, linewidth=3, color='cyan', label='TORRENT')
        plt.plot(x, Y_RLHH, linestyle='-', marker='o', markersize=5, linewidth=3, color='red', label='RLHH')

        plt.xlabel(u'Uncorrupted Data Size(K)')
        plt.ylabel(u'Running Time(s)')

        # plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        # plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.4, 0.7))
        #plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.yscale('log')

        #plt.ylim(-0.1, 40)
        plt.ylim(-20, 40)

        plt.show()

        #pp = PdfPages("D:/Dropbox/PHD/publications/IJCAI2017_RLHH/images/beta_1.pdf")
        #plt.savefig(pp, format='pdf')
        #plt.close()

    def exp_beta_recovery(self):

        result_dir = '../RLHH/result/'

        ''' beta recovery '''
        # figure 1a:
        k = 1
        p = 100
        bNoise = 1
        #data_plot.draw_beta_recovery(result_dir, k, p, bNoise)

        ## figure 1b
        k = 2
        p = 100
        bNoise = 1
        #data_plot.draw_beta_recovery(result_dir, k, p, bNoise)

        ## figure 1c
        k = 4
        p = 100
        bNoise = 1
        #data_plot.draw_beta_recovery(result_dir, k, p, bNoise)

        ## figure 1d
        k = 2
        p = 200
        bNoise = 1
        #data_plot.draw_beta_recovery(result_dir, k, p, bNoise)

        ## figure 1e
        k = 2
        p = 200
        bNoise = 0
        #data_plot.draw_beta_recovery(result_dir, k, p, bNoise)

        ## figure 1f
        k  = 4
        p = 100
        bNoise = 1
        #data_plot.draw_beta_recovery(result_dir, k, p, bNoise)

    def exp_runtime(self):
        result_dir = '../RLHH/result/'

        ## Figure 4a
        k = 4
        p = 400
        bNoise = 0
        #data_plot.draw_runtime_cr(result_dir, k, p, bNoise)

        ## Figure 4a
        p = 100
        bNoise = 1
        cr = 0.1
        data_plot.draw_runtime_datasize(result_dir, cr, p, bNoise)

if __name__ == '__main__':

    data_plot = DataPlot()

    ### draw residual description
    matlab_file = "sort_r.mat"
    #data_plot.draw_residual(matlab_file)

    ### draw residual iteration
    #data_plot.draw_residual_iter()

    ### draw param score
    matlab_file = "../RLHH/result/param_score.mat"
    data_plot.draw_param_score(matlab_file)

    ''' beta recovery '''
    #data_plot.exp_beta_recovery()

    ''' runtime per corruption rate '''
    #data_plot.exp_runtime()
    # data_plot.draw_runtime_cr(result_dir, k, p, noise_str)

    ''' runtime per data size '''
    #cr = 0.1
    #data_plot.draw_runtime_datasize(result_dir, cr, p, noise_str)

