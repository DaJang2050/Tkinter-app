import tkinter as tk
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import traceback


class SineWaveApp:
    def __init__(self, root):
        """初始化应用"""
        self.root = root
        self.root.title("正弦曲线绘图示例")
        self.root.geometry("800x500")
        self.root.configure(bg='white')
        
        # 居中窗口
        self.center_window(800, 500)
        
        # 创建图表区域
        self.frame = tk.Frame(self.root)
        self.frame.pack(side=tk.TOP, fill=tk.BOTH, expand=1)
        
        # 创建控制区域
        self.control_frame = tk.Frame(self.root, bg='white')
        self.control_frame.pack(side=tk.BOTTOM, fill=tk.X)
        
        # 创建按钮
        self.plot_button = tk.Button(
            self.control_frame, 
            text="点击显示正弦曲线", 
            command=self.plot_sine_wave,
            bg='#4CAF50',  # 绿色按钮
            fg='white',
            padx=10,
            pady=5,
            relief=tk.RAISED,
            font=('Arial', 10, 'bold')
        )
        self.plot_button.pack(pady=10, padx=10)
        
        # 图表和画布变量
        self.fig = None
        self.canvas = None

    def center_window(self, width, height):
        """将窗口居中显示"""
        screen_width = self.root.winfo_screenwidth()
        screen_height = self.root.winfo_screenheight()
        x = (screen_width // 2) - (width // 2)
        y = (screen_height // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')

    def clear_frame(self):
        """清除框架中的所有部件"""
        for widget in self.frame.winfo_children():
            widget.destroy()
        
        # 确保释放之前的图表资源
        if self.fig:
            plt.close(self.fig)
            self.fig = None
        if self.canvas:
            self.canvas = None

    def plot_sine_wave(self):
        """绘制正弦曲线"""
        try:
            # 显示等待提示
            self.plot_button.config(text="绘制中...", state=tk.DISABLED)
            self.root.update()
            
            # 清除之前的图表
            self.clear_frame()
            
            # 创建Figure对象
            self.fig = Figure(figsize=(5, 3), dpi=100)
            ax = self.fig.add_subplot(111)
            
            # 生成正弦波数据
            x = np.linspace(0, 2*np.pi, 100)
            y = np.sin(x)
            
            # 绘制正弦曲线
            ax.plot(x, y, color='blue', linewidth=2)
            ax.set_title("Sine Wave", fontsize=12, fontweight='bold')
            ax.set_xlabel("X-axis")
            ax.set_ylabel("Y-axis")
            ax.grid(True, linestyle='--', alpha=0.7)
            
            # 将matplotlib图形嵌入到tkinter窗口
            self.canvas = FigureCanvasTkAgg(self.fig, master=self.frame)
            self.canvas.draw()
            self.canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=1)
            
            # 恢复按钮状态
            self.plot_button.config(text="点击显示正弦曲线", state=tk.NORMAL)
            
        except Exception as e:
            # 错误处理
            print(f"绘图时发生错误: {e}")
            traceback.print_exc()
            
            # 显示错误信息
            error_label = tk.Label(
                self.frame, 
                text=f"绘图出错: {str(e)}", 
                fg="red", 
                bg="white"
            )
            error_label.pack(pady=20)
            
            # 恢复按钮状态
            self.plot_button.config(text="重试", state=tk.NORMAL)


# 创建主窗口和应用
if __name__ == "__main__":
    root = tk.Tk()
    app = SineWaveApp(root)
    root.mainloop()
